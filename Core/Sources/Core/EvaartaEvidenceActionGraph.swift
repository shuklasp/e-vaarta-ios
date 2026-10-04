import Foundation

public enum EvaartaSemanticNodeType: String, Codable, Sendable {
    case communication, document, evidence, claim, finding, decision, task, project, report, citation
}

public enum EvaartaSemanticEdgeType: String, Codable, Sendable {
    case derivedFrom, supports, contradicts, references, resultsIn, assignedTo, reports, communicates
}

public struct EvaartaSemanticNode: Codable, Equatable, Sendable {
    public let id: String
    public let type: EvaartaSemanticNodeType
    public let title: String
    public let sourceIds: [String]
    public let revisionId: String?
    public let properties: [String: String]

    public init(id: String, type: EvaartaSemanticNodeType, title: String = "", sourceIds: [String] = [], revisionId: String? = nil, properties: [String: String] = [:]) {
        self.id = id; self.type = type; self.title = title; self.sourceIds = sourceIds; self.revisionId = revisionId; self.properties = properties
    }
}

public struct EvaartaSemanticEdge: Codable, Equatable, Sendable {
    public let from: String
    public let to: String
    public let type: EvaartaSemanticEdgeType
    public let evidenceIds: [String]

    public init(from: String, to: String, type: EvaartaSemanticEdgeType, evidenceIds: [String] = []) {
        self.from = from; self.to = to; self.type = type; self.evidenceIds = evidenceIds
    }
}

public struct EvaartaSemanticGraph: Codable, Equatable, Sendable {
    public let nodes: [EvaartaSemanticNode]
    public let edges: [EvaartaSemanticEdge]

    public init(nodes: [EvaartaSemanticNode], edges: [EvaartaSemanticEdge]) {
        self.nodes = nodes; self.edges = edges
    }
}

public enum EvaartaEvidenceActionGraph {
    public static func validate(_ graph: EvaartaSemanticGraph) -> Bool {
        let ids = graph.nodes.map(.id)
        guard !ids.contains(where: .isEmpty), ids.count == Set(ids).count else { return false }
        return graph.edges.allSatisfy {
            $0.from != $0.to && ids.contains($0.from) && ids.contains($0.to)
        }
    }

    public static func nodesOfType(_ graph: EvaartaSemanticGraph, _ type: EvaartaSemanticNodeType) -> [EvaartaSemanticNode] {
        graph.nodes.filter { $0.type == type }
    }

    public static func linkedNodes(_ graph: EvaartaSemanticGraph, nodeId: String, edgeType: EvaartaSemanticEdgeType? = nil) -> [EvaartaSemanticNode] {
        var ids = Set<String>()
        for edge in graph.edges where edgeType == nil || edge.type == edgeType {
            if edge.from == nodeId { ids.insert(edge.to) }
            if edge.to == nodeId { ids.insert(edge.from) }
        }
        return graph.nodes.filter { ids.contains($0.id) }
    }
}
