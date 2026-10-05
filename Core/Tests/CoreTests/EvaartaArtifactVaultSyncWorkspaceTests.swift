import XCTest
final class EvaartaArtifactVaultSyncWorkspaceTests:XCTestCase {
 func testTransferIsResumable(){var t=EvaartaTransfer(id:"t",contentHash:"h",totalChunks:2);t=EvaartaArtifactSync.accept(t,index:1);XCTAssertEqual(EvaartaArtifactSync.missing(t),[0]);t=EvaartaArtifactSync.accept(t,index:0);XCTAssertEqual(t.state,"complete")}
 func testVaultUsesHashIdentity(){let v=EvaartaArtifactVault.put(EvaartaVault(),EvaartaVaultObject(contentHash:"ABC",size:1));XCTAssertEqual(v.objects.count,1)}
}