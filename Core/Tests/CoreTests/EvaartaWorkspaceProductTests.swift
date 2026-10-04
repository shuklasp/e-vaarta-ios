import XCTest
@testable import Core
final class EvaartaWorkspaceProductTests: XCTestCase {
 func testNavigation(){XCTAssertEqual(EvaartaWorkspaceProduct.navigate(EvaartaWorkspaceShell(),route:"project")?.route,"project")}
 func testIdentity(){XCTAssertTrue(EvaartaWorkspaceProduct.identityMatch(EvaartaIdentity(id:"a",personId:"p",type:"email",value:"A@x"),EvaartaIdentity(id:"b",personId:"q",type:"email",value:"a@x")))}
 func testDedupe(){let a=EvaartaAttachment(id:"1",hash:"h",name:"a",mime:"text/plain",size:1);let b=EvaartaAttachment(id:"2",hash:"h",name:"b",mime:"text/plain",size:1);XCTAssertEqual(EvaartaWorkspaceProduct.dedupeAttachments([a,b]).count,1)}
}