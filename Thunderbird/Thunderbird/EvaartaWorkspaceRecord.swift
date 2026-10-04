import Foundation

/// Storage-neutral metadata for an offline workspace snapshot.
struct EvaartaWorkspaceRecord: Codable, Identifiable {
    static let persistenceVersion = 1

    let id: String
    var workspaceId: String
    var revision: Int
    var writerId: String
    var writtenAt: Date
    var checksum: String
    var workspace: EvaartaDocumentWorkspace

    init(
        workspaceId: String,
        revision: Int,
        writerId: String = "local",
        writtenAt: Date = Date(),
        checksum: String,
        workspace: EvaartaDocumentWorkspace
    ) {
        self.id = workspaceId
        self.workspaceId = workspaceId
        self.revision = revision
        self.writerId = writerId
        self.writtenAt = writtenAt
        self.checksum = checksum
        self.workspace = workspace
    }
}

enum EvaartaWorkspaceWriteStatus {
    case create
    case replace
    case conflict
}
