import XCTest
@testable import Thunderbird
final class EvaartaWorkspaceExperienceTests:XCTestCase{
 func testDeepLinkParsing(){let url=URL(string:"evaarta://workspace/ws-1?document=doc-1&item=item-1")!;let link=EvaartaDeepLinks.parse(url);XCTAssertEqual(link?.workspaceId,"ws-1");XCTAssertEqual(link?.documentId,"doc-1")}
 func testStateSelection(){let store=EvaartaWorkspaceStateStore();store.selectDocument("doc-1");store.setSearchQuery("policy");XCTAssertEqual(store.state.selectedDocumentId,"doc-1");XCTAssertEqual(store.state.searchQuery,"policy")}
}
