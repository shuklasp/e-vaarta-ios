import Foundation

/// Portable semantic model for the e-Vaarta document workspace.
/// The model intentionally keeps source anchors separate from presentation.
struct EvaartaDocumentWorkspace: Codable, Identifiable {
    static let modelVersion = 2

    let id: String
    var name: String
    var description: String
    var documents: [EvaartaDocument]
    var items: [EvaartaWorkspaceItem]
    var evidenceGroups: [EvaartaEvidenceGroup]
    var links: [EvaartaWorkspaceLink]
}

enum EvaartaDocumentKind: String, Codable {
    case pdf
    case word
    case powerpoint
    case image
    case web
    case email
    case other
}

struct EvaartaDocument: Codable, Identifiable {
    let id: String
    var title: String
    var kind: EvaartaDocumentKind
    var sourceRef: String?
    var mimeType: String?
}

struct EvaartaSourceAnchor: Codable {
    let documentId: String
    var page: Int?
    var startOffset: Int?
    var endOffset: Int?
    var quote: String?
}

enum EvaartaWorkspaceItemKind: String, Codable {
    case excerpt
    case note
    case annotation
}

struct EvaartaWorkspaceItem: Codable, Identifiable {
    let id: String
    let kind: EvaartaWorkspaceItemKind
    var title: String?
    var text: String?
    var anchor: EvaartaSourceAnchor?
    var annotationType: String?
    var color: String?
}

enum EvaartaLinkKind: String, Codable {
    case relatesTo = "relates-to"
    case supports
    case contradicts
    case derivedFrom = "derived-from"
    case references
}

struct EvaartaEvidenceGroup: Codable, Identifiable {
    let id: String
    var name: String
    var description: String
    var documentId: String?
    var itemIds: [String]
}

struct EvaartaWorkspaceLink: Codable, Identifiable {
    let id: String
    let fromId: String
    let toId: String
    let kind: EvaartaLinkKind
}
