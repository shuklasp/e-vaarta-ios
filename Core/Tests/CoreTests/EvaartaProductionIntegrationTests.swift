import XCTest
@testable import Core
final class EvaartaProductionIntegrationTests:XCTestCase{
 func testAuthorization(){let t=EvaartaCapabilityToken(subject:"u",capability:"send",resource:"conversation:c",nonce:"n");XCTAssertTrue(EvaartaProductionIntegration.authorize(t,required:"send",resource:"conversation:c"));XCTAssertFalse(EvaartaProductionIntegration.authorize(t,required:"delete",resource:"conversation:c"))}
 func testContract(){XCTAssertTrue(EvaartaProductionIntegration.contract.contains("provider-adapters"));XCTAssertTrue(EvaartaProductionIntegration.contract.contains("release-validation"))}
}
