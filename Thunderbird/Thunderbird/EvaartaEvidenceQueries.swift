import Foundation

/// UI-independent source evidence queries for e-Vaarta clients.
/// The query derives results from the canonical workspace instead of storing
/// a second source-to-evidence index.
enum EvaartaEvidenceQueries {
    struct Summary {
        let documentId: String
        let evidenceCount: Int
        let excerptCount: Int
        let annotationCount: Int
        let groupCount: Int
        let pages: [Int]
    }

    static func evidence(
        in workspace: EvaartaDocumentWorkspace,
        documentId: String,
        kind: EvaartaWorkspaceItemKind? = nil,
        page: Int? = nil,
        groupItemIds: Set<String>? = nil
    ) -> [EvaartaWorkspaceItem] {
        workspace.items
            .filter { item in
                guard let anchor = item.anchor,
                      anchor.documentId == documentId else { return false }
                if let kind, item.kind != kind { return false }
                if let page, anchor.page != page { return false }
                if let groupItemIds, !groupItemIds.contains(item.id) { return false }
                return item.kind == .excerpt || item.kind == .annotation
            }
            .sorted {
                let lhs = ($0.anchor?.page ?? Int.max,
                           $0.anchor?.startOffset ?? Int.max,
                           $0.id)
                let rhs = ($1.anchor?.page ?? Int.max,
                           $1.anchor?.startOffset ?? Int.max,
                           $1.id)
                return lhs < rhs
            }
    }

    static func summary(
        in workspace: EvaartaDocumentWorkspace,
        documentId: String
    ) -> Summary {
        let items = evidence(in: workspace, documentId: documentId)
        return Summary(
            documentId: documentId,
            evidenceCount: items.count,
            excerptCount: items.filter { $0.kind == .excerpt }.count,
            annotationCount: items.filter { $0.kind == .annotation }.count,
            groupCount: 0,
            pages: Array(Set(items.compactMap { $0.anchor?.page })).sorted()
        )
    }
}
