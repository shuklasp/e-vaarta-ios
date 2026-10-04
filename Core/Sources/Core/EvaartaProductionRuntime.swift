import Foundation

public enum EvaartaRuntimeCapability: String, Codable, Sendable {
    case pdf, pdfProduction = "pdf-production", research, search, documents, knowledge,
         citations, ai, projects, collaboration, mobile, accessibility, security,
         interoperability, automation
}

public struct EvaartaRuntimeAdapter: Sendable {
    public let capability: EvaartaRuntimeCapability
    public let operations: Set<String>
    public init(capability: EvaartaRuntimeCapability, operations: Set<String> = []) {
        self.capability = capability; self.operations = operations
    }
    public func supports(_ operation: String) -> Bool { operations.contains(operation) }
    public func require(_ operation: String) {
        precondition(supports(operation), "Runtime operation not bound: \(capability.rawValue)/\(operation)")
    }
}

public enum EvaartaProductionRuntime {
    public static let tier1: [EvaartaRuntimeCapability] = [.pdf, .pdfProduction, .ai, .collaboration, .mobile, .security]
    public static let tier2: [EvaartaRuntimeCapability] = [.research, .search, .documents, .knowledge, .citations, .projects, .accessibility, .interoperability, .automation]
    public static let tier3 = ["evidence-graph","provenance","grounded-ai","evidence-to-decision","decision-to-task","evidence-to-project","report-traceability","communication-traceability","end-to-end-traceability"]
}
