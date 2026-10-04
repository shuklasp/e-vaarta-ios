import XCTest
@testable import Thunderbird

final class EvaartaNativeTransportsTests: XCTestCase {
    func testAttachmentRoundTrip() {
        let source = Data((0..<700000).map { UInt8($0 % 251) })
        let chunks = EvaartaAttachmentTransfer.chunk(attachmentId: "a1", data: source)
        XCTAssertEqual(chunks.count, 3)
        XCTAssertEqual(EvaartaAttachmentTransfer.assemble(chunks), source)
    }
}
