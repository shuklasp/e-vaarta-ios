import XCTest
@testable import Core
final class EvaartaBestInClassProgramTests:XCTestCase{func testCoverage(){XCTAssertGreaterThanOrEqual(EvaartaBestInClassProgram.classes.count,20);XCTAssertTrue(EvaartaBestInClassProgram.principles.contains("one-semantic-graph"))}func testGates(){XCTAssertTrue(EvaartaBestInClassProgram.requiresHumanAndAdversarial(evidenceCount:2,human:true,adversarial:true))}}