import Foundation
import XCTest

final class EvaartaArtifactLifecycleTests: XCTestCase {
    func testForwardsArtifactsBetweenTasks() {
        let a=EvaartaArtifact(id:"a",type:"photo",contentHash:"sha")
        let link=EvaartaArtifactLifecycle.link(a,targetType:"task",targetId:"one",linkId:"l1")
        let forwarded=EvaartaArtifactLifecycle.forwardTaskArtifacts([link],fromTaskId:"one",toTaskId:"two")
        XCTAssertEqual(forwarded.first?.targetId,"two")
        XCTAssertEqual(forwarded.first?.artifactId,"a")
    }
    func testBlocksRestrictedExternalSharing() {
        let a=EvaartaArtifact(id:"a",type:"document",security:"restricted")
        XCTAssertEqual(EvaartaArtifactLifecycle.shareDecision(a,recipientType:"external"),EvaartaArtifactLifecycle.shareBlock)
    }
    func testContractIsOfflineFirst() { XCTAssertTrue(EvaartaArtifactLifecycle.contract.contains("offline-first")) }
}
