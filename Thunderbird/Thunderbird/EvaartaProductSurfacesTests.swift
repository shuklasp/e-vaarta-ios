import XCTest
@testable import Thunderbird
final class EvaartaProductSurfacesTests:XCTestCase { func testOfflineDefaults(){let s=EvaartaWorkspaceSurfaceState(selectedDocumentId:nil,selectedItemId:nil,query:"");XCTAssertTrue(s.offlineReady);let sync=EvaartaSyncSurfaceState();XCTAssertFalse(sync.networkEnabled);XCTAssertEqual(sync.status,"local-only")} }
