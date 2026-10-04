import XCTest
@testable import Core

final class EvaartaAdvancedContractsTests: XCTestCase {
    func testContractsValidate() {
        XCTAssertTrue(EvaartaAdvancedContracts.validProduction(EvaartaPdfProductionRequest(operation:"redact")))
        XCTAssertTrue(EvaartaAdvancedContracts.validResearch(EvaartaResearchCard(id:"c",sourceId:"d",anchor:"p1")))
        XCTAssertTrue(EvaartaAdvancedContracts.validCitation(EvaartaScholarlyRecord(id:"c")))
        XCTAssertTrue(EvaartaAdvancedContracts.validMarkdown(EvaartaMarkdownDocument(id:"d",path:"d.md")))
        XCTAssertTrue(EvaartaAdvancedContracts.validAiRequest(EvaartaGroundedAiRequest(query:"q")))
        XCTAssertTrue(EvaartaAdvancedContracts.validEvent(EvaartaSemanticEvent(id:"e",actorId:"a",lamport:1,objectId:"d",type:"create")))
        XCTAssertTrue(EvaartaAdvancedContracts.validCapture(EvaartaCapture(id:"c",type:.scan,uri:"file://scan")))
    }
}
