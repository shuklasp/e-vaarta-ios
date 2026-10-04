import XCTest
@testable import Core

final class EvaartaBestInClassTests: XCTestCase {
    func testPDFState() {
        XCTAssertTrue(EvaartaBestInClass.validPdfState(EvaartaPdfReaderState(pageCount: 100, currentPage: 50)))
        XCTAssertFalse(EvaartaBestInClass.validPdfState(EvaartaPdfReaderState(pageCount: 10, currentPage: 11)))
    }

    func testEvidenceAnchor() {
        let e = EvaartaPdfEvidence(anchor: EvaartaPdfAnchor(documentId: "doc", page: 2), quote: "quote")
        XCTAssertTrue(EvaartaBestInClass.groundedEvidence(e))
    }
}
