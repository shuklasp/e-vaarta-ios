import XCTest
@testable import Thunderbird
final class EvaartaDistributedArchitectureTests:XCTestCase{func testQueue(){let q=EvaartaStoreForwardQueue();q.enqueue(EvaartaEnvelope(messageId:"m",source:"a",destination:"b",type:"task.created",ciphertext:nil,signature:"s",hopLimit:8));XCTAssertEqual(q.snapshot().count,1)}func testFailClosed(){let m=EvaartaTransportManager([]);XCTAssertTrue(m.available().isEmpty)}func testReplay(){let g=EvaartaReplayGuard();XCTAssertTrue(g.accept("x"));XCTAssertFalse(g.accept("x"))}}
