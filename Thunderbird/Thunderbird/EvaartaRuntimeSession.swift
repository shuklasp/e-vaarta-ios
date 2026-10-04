import Foundation
import CryptoKit

struct EvaartaSessionHello: Codable {
    let actorId: String
    let fingerprint: String
    let nonce: String
    let signature: Data
}

final class EvaartaAuthenticatedSession {
    private let identity: Curve25519.Signing.PrivateKey
    private let peerKey: Curve25519.Signing.PublicKey
    private(set) var authenticated = false
    private var localNonce: String?

    init(identity: Curve25519.Signing.PrivateKey, peerKey: Curve25519.Signing.PublicKey) {
        self.identity = identity
        self.peerKey = peerKey
    }

    func createHello(actorId: String, fingerprint: String) throws -> EvaartaSessionHello {
        let nonce = UUID().uuidString
        localNonce = nonce
        let payload = Data("(actorId)|(fingerprint)|(nonce)".utf8)
        return EvaartaSessionHello(actorId: actorId, fingerprint: fingerprint, nonce: nonce,
                                   signature: try identity.signature(for: payload))
    }

    func accept(response: EvaartaSessionHello) throws {
        guard response.nonce == localNonce else { throw NSError(domain: "e-Vaarta", code: 2) }
        let payload = Data("(response.actorId)|(response.fingerprint)|(response.nonce)".utf8)
        guard peerKey.isValidSignature(response.signature, for: payload) else {
            throw NSError(domain: "e-Vaarta", code: 3)
        }
        authenticated = true
    }

    func close() {
        localNonce = nil
        authenticated = false
    }
}
