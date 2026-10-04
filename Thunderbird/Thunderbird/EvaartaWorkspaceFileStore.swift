import Foundation

/// Crash-safe local persistence for e-Vaarta workspace records.
///
/// The store keeps a primary snapshot and a last-known-good backup. Codable
/// validation happens before either snapshot is accepted by the caller.
final class EvaartaWorkspaceFileStore {
    enum Source {
        case primary
        case backup
    }

    struct LoadResult {
        let record: EvaartaWorkspaceRecord
        let source: Source
        let recovered: Bool
    }

    private let directory: URL
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let fileManager: FileManager

    init(
        directory: URL? = nil,
        fileManager: FileManager = .default,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.fileManager = fileManager
        self.encoder = encoder
        self.decoder = decoder
        self.directory = directory ?? fileManager
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("e-Vaarta/workspaces", isDirectory: true)
    }

    @discardableResult
    func save(_ record: EvaartaWorkspaceRecord) throws -> EvaartaWorkspaceWriteStatus {
        try fileManager.createDirectory(
            at: directory,
            withIntermediateDirectories: true
        )

        let paths = paths(for: record.workspaceId)
        let current = try loadValid(paths.primary) ?? loadValid(paths.backup)

        let status: EvaartaWorkspaceWriteStatus
        if let current {
            guard current.workspaceId == record.workspaceId else {
                throw StoreError.identityMismatch
            }
            if record.revision == current.revision + 1 {
                status = .replace
            } else if record.revision <= current.revision {
                throw StoreError.conflict
            } else {
                throw StoreError.revisionGap
            }
        } else {
            status = .create
        }

        let data = try encoder.encode(record)
        let temp = paths.temp
        try data.write(to: temp, options: [.atomic])

        if fileManager.fileExists(atPath: paths.primary.path) {
            if fileManager.fileExists(atPath: paths.backup.path) {
                try fileManager.removeItem(at: paths.backup)
            }
            try fileManager.moveItem(at: paths.primary, to: paths.backup)
        }

        do {
            try fileManager.moveItem(at: temp, to: paths.primary)
        } catch {
            // The previous valid snapshot remains available in .bak.
            throw StoreError.commitFailed(error)
        }

        return status
    }

    func load(_ workspaceId: String) throws -> LoadResult? {
        let paths = paths(for: workspaceId)

        if let record = try loadValid(paths.primary) {
            guard record.workspaceId == workspaceId else {
                throw StoreError.identityMismatch
            }
            return LoadResult(record: record, source: .primary, recovered: false)
        }

        if let record = try loadValid(paths.backup) {
            guard record.workspaceId == workspaceId else {
                throw StoreError.identityMismatch
            }
            return LoadResult(record: record, source: .backup, recovered: true)
        }

        if !fileManager.fileExists(atPath: paths.primary.path) &&
            !fileManager.fileExists(atPath: paths.backup.path) {
            return nil
        }

        throw StoreError.noValidSnapshot
    }

    @discardableResult
    func recover(_ workspaceId: String) throws -> LoadResult? {
        guard let loaded = try load(workspaceId) else { return nil }
        guard loaded.source == .backup else { return loaded }

        let paths = paths(for: workspaceId)
        let data = try encoder.encode(loaded.record)
        try data.write(to: paths.temp, options: [.atomic])
        if fileManager.fileExists(atPath: paths.primary.path) {
            try fileManager.removeItem(at: paths.primary)
        }
        try fileManager.moveItem(at: paths.temp, to: paths.primary)

        return LoadResult(record: loaded.record, source: .primary, recovered: true)
    }

    func remove(_ workspaceId: String) throws {
        let paths = paths(for: workspaceId)
        for url in [paths.primary, paths.backup, paths.temp] {
            if fileManager.fileExists(atPath: url.path) {
                try fileManager.removeItem(at: url)
            }
        }
    }

    enum StoreError: Error {
        case identityMismatch
        case conflict
        case revisionGap
        case noValidSnapshot
        case commitFailed(Error)
    }

    private func loadValid(_ url: URL) throws -> EvaartaWorkspaceRecord? {
        guard fileManager.fileExists(atPath: url.path) else { return nil }
        do {
            return try decoder.decode(
                EvaartaWorkspaceRecord.self,
                from: Data(contentsOf: url)
            )
        } catch {
            return nil
        }
    }

    private func paths(for workspaceId: String) -> (primary: URL, backup: URL, temp: URL) {
        let safeID = workspaceId
            .map { $0.isLetter || $0.isNumber || $0 == "." || $0 == "-" || $0 == "_" ? String($0) : "_" }
            .joined()
        let primary = directory.appendingPathComponent("\(safeID).json")
        return (
            primary,
            directory.appendingPathComponent("\(safeID).json.bak"),
            directory.appendingPathComponent("\(safeID).json.tmp")
        )
    }
}
