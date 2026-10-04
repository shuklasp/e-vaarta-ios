import Foundation

struct EvaartaSyncManifest: Codable {
    let manifestVersion: Int
    let workspaceId: String
    let revision: Int
    let checksum: String
    let writerId: String
    let deviceId: String
    let updatedAt: Date
}

enum EvaartaSyncComparison {
    case equal, localNewer, remoteNewer, conflict
}

enum EvaartaSyncManifests {
    static func compare(_ local: EvaartaSyncManifest, _ remote: EvaartaSyncManifest) -> EvaartaSyncComparison {
        precondition(local.workspaceId == remote.workspaceId, "Workspace identity mismatch")
        if local.checksum == remote.checksum { return .equal }
        if local.revision > remote.revision { return .localNewer }
        if local.revision < remote.revision { return .remoteNewer }
        return .conflict
    }
}

final class EvaartaWorkspaceRepository {
    private let store: EvaartaWorkspaceFileStore

    init(store: EvaartaWorkspaceFileStore) {
        self.store = store
    }

    func load(_ workspaceId: String) throws -> EvaartaWorkspaceRecord? {
        try store.load(workspaceId)?.record
    }

    @discardableResult
    func save(_ record: EvaartaWorkspaceRecord) throws -> EvaartaWorkspaceWriteStatus {
        try store.save(record)
    }

    func recover(_ workspaceId: String) throws -> EvaartaWorkspaceRecord? {
        try store.recover(workspaceId)?.record
    }

    func delete(_ workspaceId: String) throws {
        try store.remove(workspaceId)
    }
}
