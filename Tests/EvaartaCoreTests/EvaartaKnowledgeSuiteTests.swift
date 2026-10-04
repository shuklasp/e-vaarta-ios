import XCTest
@testable import EvaartaCore
final class EvaartaKnowledgeSuiteTests:XCTestCase{
 func testEvidenceLineage(){let e=EvaartaKnowledgeSuite.evidence(documentId:"doc",anchor:EvaartaAnchor(documentId:"doc",page:2,quote:"solar"),text:"solar");let c=EvaartaEntity(id:"claim",kind:.claim);let r=EvaartaKnowledgeSuite.relation(from:e.id,to:c.id,kind:.supports);XCTAssertEqual(EvaartaKnowledgeSuite.lineage(c.id,relations:[r]),[e.id])}
 func testProjectStatus(){let a=EvaartaEntity(kind:.task,data:["status":"completed"]);let b=EvaartaEntity(kind:.task,data:["status":"open"]);let s=EvaartaKnowledgeSuite.projectStatus([a,b]);XCTAssertEqual(s.total,2);XCTAssertEqual(s.completed,1);XCTAssertEqual(s.open,1)}
}
