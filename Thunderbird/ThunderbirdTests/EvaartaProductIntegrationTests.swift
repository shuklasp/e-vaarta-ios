import XCTest
@testable import Thunderbird
final class EvaartaProductIntegrationTests:XCTestCase{
 func testQueueRetry(){let q=EvaartaOfflineQueue();q.enqueue(operation:"save",payload:"x");q.retryHead("offline");XCTAssertEqual(q.snapshot().first?.attempts,1)}
}