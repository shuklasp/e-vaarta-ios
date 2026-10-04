import Foundation

struct EvaartaAttachmentChunk {
    let attachmentId: String
    let index: Int
    let total: Int
    let data: Data
}

enum EvaartaAttachmentTransfer {
    static let defaultChunkSize = 256 * 1024

    static func chunk(attachmentId: String, data: Data,
                      chunkSize: Int = defaultChunkSize) -> [EvaartaAttachmentChunk] {
        precondition(chunkSize > 0)
        let total = (data.count + chunkSize - 1) / chunkSize
        return (0..<total).map { index in
            let start = index * chunkSize
            let end = min(start + chunkSize, data.count)
            return EvaartaAttachmentChunk(attachmentId: attachmentId, index: index,
                                          total: total, data: data.subdata(in: start..<end))
        }
    }

    static func assemble(_ chunks: [EvaartaAttachmentChunk]) -> Data {
        let ordered = chunks.sorted { $0.index < $1.index }
        precondition(!ordered.isEmpty)
        precondition(ordered.enumerated().allSatisfy { $0.element.index == $0.offset })
        precondition(ordered.allSatisfy { $0.total == ordered.count })
        return ordered.reduce(into: Data()) { $0.append($1.data) }
    }
}
