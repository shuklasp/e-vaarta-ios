import Foundation

/// Portable semantic model for the e-Vaarta document workspace.
/// The model intentionally keeps source anchors separate from presentation.
struct EvaartaDocumentWorkspace: Codable, Identifiable {
    static let currentModelVersion = 2

    var modelVersion: Int
    let id: String
    var name: String
    var description: String
    var documents: [EvaartaDocument]
    var items: [EvaartaWorkspaceItem]
    var evidenceGroups: [EvaartaEvidenceGroup]
    var links: [EvaartaWorkspaceLink]

    enum CodingKeys: String, CodingKey {
        case modelVersion, id, name, description, documents, items, evidenceGroups, links
    }

    init(id: String, name: String, description: String, documents: [EvaartaDocument], items: [EvaartaWorkspaceItem], evidenceGroups: [EvaartaEvidenceGroup] = [], links: [EvaartaWorkspaceLink], modelVersion: Int = Self.currentModelVersion) {
        self.modelVersion = modelVersion
        self.id = id
        self.name = name
        self.description = description
        self.documents = documents
        self.items = items
        self.evidenceGroups = evidenceGroups
        self.links = links
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        modelVersion = try values.decodeIfPresent(Int.self, forKey: .modelVersion) ?? 1
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        documents = try values.decodeIfPresent([EvaartaDocument].self, forKey: .documents) ?? []
        items = try values.decodeIfPresent([EvaartaWorkspaceItem].self, forKey: .items) ?? []
        evidenceGroups = try values.decodeIfPresent([EvaartaEvidenceGroup].self, forKey: .evidenceGroups) ?? []
        links = try values.decodeIfPresent([EvaartaWorkspaceLink].self, forKey: .links) ?? []
    }
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
