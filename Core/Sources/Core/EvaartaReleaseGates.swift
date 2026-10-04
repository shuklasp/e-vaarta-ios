import Foundation

public enum EvaartaValidationDimension: String, Codable, Sendable {
    case unit, integration, realData = "real-data", adversarial, performance,
         accessibility, deviceOffline = "device-offline", interoperability, humanBenchmark = "human-benchmark"
}

public struct EvaartaValidationEvidence: Codable, Equatable, Sendable {
    public let dimension: EvaartaValidationDimension
    public let status: String
    public let artifact: String?
    public let corpusId: String?
    public let version: String?
    public let hardware: String?
    public init(dimension: EvaartaValidationDimension, status: String = "pending", artifact: String? = nil, corpusId: String? = nil, version: String? = nil, hardware: String? = nil) {
        self.dimension = dimension; self.status = status; self.artifact = artifact; self.corpusId = corpusId; self.version = version; self.hardware = hardware
    }
}

public struct EvaartaReleaseRecord: Codable, Equatable, Sendable {
    public let productClass: String
    public let capability: String
    public let implementationStatus: String
    public let evidence: [EvaartaValidationEvidence]
    public init(productClass: String, capability: String, implementationStatus: String = "implemented", evidence: [EvaartaValidationEvidence] = []) {
        self.productClass = productClass; self.capability = capability; self.implementationStatus = implementationStatus; self.evidence = evidence
    }
}

public enum EvaartaReleaseGates {
    public static func evaluate(_ record: EvaartaReleaseRecord) -> String {
        guard record.implementationStatus == "integrated" else { return "integrated" }
        return EvaartaValidationDimension.allCases.allSatisfy { dimension in
            record.evidence.contains { $0.dimension == dimension && $0.status == "passed" }
        } ? "validated" : "integrated"
    }
}

extension EvaartaValidationDimension: CaseIterable {}

public struct EvaartaBenchmarkCase: Codable, Equatable, Sendable {
    public let id: String
    public let domain: String
    public let task: String
    public let corpusId: String
    public init(id: String, domain: String, task: String, corpusId: String) {
        self.id = id; self.domain = domain; self.task = task; self.corpusId = corpusId
    }
}

public struct EvaartaBenchmarkResult: Codable, Equatable, Sendable {
    public let caseId: String
    public let product: String
    public let version: String
    public let elapsedMs: Int64
    public let completed: Bool
    public let errors: [String]
    public init(caseId: String, product: String, version: String, elapsedMs: Int64, completed: Bool, errors: [String] = []) {
        self.caseId = caseId; self.product = product; self.version = version; self.elapsedMs = elapsedMs; self.completed = completed; self.errors = errors
    }
}

public struct EvaartaEvidenceActionStage: Codable, Equatable, Sendable {
    public let stage: String
    public let id: String
    public let sourceIds: [String]
    public init(stage: String, id: String, sourceIds: [String]) { self.stage = stage; self.id = id; self.sourceIds = sourceIds }
}

public enum EvaartaEvidenceActionBenchmark {
    public static let stages = ["communication","document","evidence","claim","finding","decision","task","project","report","citation","communication-output"]
    public static func validate(_ trace: [EvaartaEvidenceActionStage]) -> Bool {
        stages.allSatisfy { stage in trace.contains { $0.stage == stage && !$0.id.isEmpty && !$0.sourceIds.isEmpty } }
    }
}
