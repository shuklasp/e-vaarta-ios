import XCTest
@testable import Core
final class EvaartaKnowledgeTests: XCTestCase {
 func testGroundedAnswerRequiresEvidence(){let a=EvaartaGroundedAnswer(answer:"x",claims:[EvaartaClaim(id:"c",text:"x",evidenceIds:["e"])],evidence:[EvaartaEvidenceRef(id:"e")]);XCTAssertTrue(a.grounded)}
 func testTaskGraphRejectsCycles(){let a=EvaartaTask(id:"a",title:"A",dependsOn:["b"]);let b=EvaartaTask(id:"b",title:"B",dependsOn:["a"]);XCTAssertFalse(EvaartaTaskGraph.isValid([a,b]))}
}
