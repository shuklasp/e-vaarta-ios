import XCTest
@testable import Core
final class EvaartaCommunicationSuiteTests:XCTestCase{
 func testIdentityAndSearch(){let p=EvaartaPerson(id:"p",name:"A",addresses:["a@x"],phones:["1"]);let m=EvaartaMessage(id:"m",conversationId:"c",senderId:"p",body:"Please complete task",channel:"email");XCTAssertEqual(EvaartaCommunicationSuite.identityMatch([p],addresses:["a@x"],phones:[]).count,1);XCTAssertEqual(EvaartaCommunicationSuite.search([m],query:"task").count,1)}
 func testReconcile(){let r=EvaartaCommunicationSuite.reconcile([EvaartaCommunicationEvent(id:"1",idempotencyKey:"k",entityId:"m",baseVersion:nil,currentVersion:nil),EvaartaCommunicationEvent(id:"2",idempotencyKey:"k",entityId:"m",baseVersion:nil,currentVersion:nil),EvaartaCommunicationEvent(id:"3",idempotencyKey:"z",entityId:"m",baseVersion:1,currentVersion:2)]);XCTAssertEqual(r.accepted.count,1);XCTAssertEqual(r.conflicts.count,1)}
 func testContract(){XCTAssertEqual(EvaartaCommunicationSuiteContract.phases.count,7);XCTAssertTrue(EvaartaCommunicationSuiteContract.capabilities.contains("communication-to-task"))}
}
