import XCTest
@testable import Core

final class EvaartaReleaseGatesTests: XCTestCase {
    func testIntegratedRequiresAllEvidence() {
        let evidence = EvaartaValidationDimension.allCases.map { EvaartaValidationEvidence(dimension: $0, status: "passed") }
        let record = EvaartaReleaseRecord(productClass: "pdf", capability: "rendering", implementationStatus: "integrated", evidence: evidence)
        XCTAssertEqual(EvaartaReleaseGates.evaluate(record), "validated")
    }

    func testEvidenceActionRequiresCompleteTrace() {
        let trace = EvaartaEvidenceActionBenchmark.stages.enumerated().map { index, stage in
            EvaartaEvidenceActionStage(stage: stage, id: "n\(index)", sourceIds: ["s\(index)"])
        }
        XCTAssertTrue(EvaartaEvidenceActionBenchmark.validate(trace))
    }
}
