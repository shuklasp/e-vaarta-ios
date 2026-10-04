import XCTest
@testable import Core
final class EvaartaTaskWorkManagementTests:XCTestCase {
 func testLifecycleAndGraph(){let a=EvaartaTask(id:"a",title:"A",estimateMinutes:60);let b=EvaartaTask(id:"b",title:"B",dependsOn:["a"]);XCTAssertTrue(EvaartaTaskWorkManagement.validateGraph([a,b]));let x=EvaartaTaskWorkManagement.accept(EvaartaTaskWorkManagement.assign(a,EvaartaAssignment(assigneeId:"u1")),true);XCTAssertEqual(x.status,"accepted")}
 func testMonitoring(){let a=EvaartaTask(id:"a",title:"A",assigneeId:"u1",estimateMinutes:60);let h=EvaartaTaskWorkManagement.monitor(a,now:Date(timeIntervalSince1970:100000),updated:Date(timeIntervalSince1970:0));XCTAssertEqual(h.health,"stalled")}
}
