import XCTest
@testable import Thunderbird

final class EvaartaRuntimePipelineTests: XCTestCase {
    func testAttachmentResume() {
        XCTAssertEqual(EvaartaAttachmentResume.missing(total: 4, received: [0, 2]), [1, 3])
    }
}
