import XCTest
@testable import Thunderbird
final class EvaartaRuntimeDistributedTests:XCTestCase{func testPairing(){let t=EvaartaTrustStore();let p=EvaartaPairingSession(t);p.begin(EvaartaTrustedPeer(actorId:"b",publicKey:"pk",fingerprint:"fp"));p.approve();XCTAssertTrue(t.isTrusted("b"))}}
