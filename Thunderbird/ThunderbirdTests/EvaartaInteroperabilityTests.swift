import XCTest
@testable import Thunderbird
final class EvaartaInteroperabilityTests: XCTestCase {
 func testAttachmentResume(){ XCTAssertEqual(EvaartaAttachmentAck(attachmentId:"a",received:[0,2]).missing(total:4),[1,3]) }
}
