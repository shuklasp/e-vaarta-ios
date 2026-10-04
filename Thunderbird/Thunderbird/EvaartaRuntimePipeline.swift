import Foundation

struct EvaartaRuntimeEnvelope { let messageId: String; let type: String; let sessionId: String?; let payload: Data }

final class EvaartaRuntimePipeline {
    private let trustStore: EvaartaTrustStore
    init(trustStore: EvaartaTrustStore) { self.trustStore = trustStore }
    func assertTrusted(_ peer: EvaartaTrustedPeer) throws {
        guard trustStore.isTrusted(peer.actorId) else {
            throw NSError(domain: "e-Vaarta", code: 20, userInfo: [NSLocalizedDescriptionKey: "peer is untrusted or revoked"])
        }
    }
}

enum EvaartaAttachmentResume {
    static func missing(total: Int, received: Set<Int>) -> [Int] {
        (0..<total).filter { !received.contains($0) }
    }
}

protocol EvaartaEmailGateway {
    func send(destination: String, body: Data) async throws
    func receive() async throws -> [Data]
}
