import XCTest
@testable import Core

final class EvaartaProductionRuntimeTests: XCTestCase {
    func testExposesAllTiers() {
        XCTAssertTrue(EvaartaProductionRuntime.tier1.contains(.pdf))
        XCTAssertTrue(EvaartaProductionRuntime.tier2.contains(.research))
        XCTAssertTrue(EvaartaProductionRuntime.tier3.contains("end-to-end-traceability"))
    }

    func testRuntimeBoundaryRejectsUnboundOperations() {
        let adapter = EvaartaRuntimeAdapter(capability: .ai, operations: ["embed"])
        XCTAssertTrue(adapter.supports("embed"))
        XCTAssertFalse(adapter.supports("chat"))
    }
}
