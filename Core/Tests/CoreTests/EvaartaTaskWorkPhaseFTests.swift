import XCTest
@testable import Core
final class EvaartaTaskWorkPhaseFTests:XCTestCase{func testGraphAndImpact(){let a=EvaartaPhaseFTask(id:"a",title:"A");let b=EvaartaPhaseFTask(id:"b",title:"B",dependsOn:["a"]);XCTAssertTrue(EvaartaTaskWorkPhaseF.validateGraph([a,b]));XCTAssertEqual(EvaartaTaskWorkPhaseF.impact([a,b],"a"),Set(["b"]))}func testScoreAndVerify(){let t=EvaartaPhaseFTask(id:"t",title:"T",skills:["pdf"]);XCTAssertGreaterThan(EvaartaTaskWorkPhaseF.score(t,personId:"p",skills:["pdf"],capacity:480,committed:0).score,0.9);XCTAssertEqual(EvaartaTaskWorkPhaseF.verify(t.withEvidence(),allowWithoutEvidence:false).status,"verified")}}
private extension EvaartaPhaseFTask{func withEvidence()->EvaartaPhaseFTask{var x=self;x.evidenceIds=["e"];return x}}
