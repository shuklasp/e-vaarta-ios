import Foundation
import Security

struct EvaartaSessionHello: Codable {
    let actorId: String
    let fingerprint: String
    let nonce: String
    let signature: Data
}

final class EvaartaSecKeySessionSigner {
    private let privateKey: SecKey
    init(privateKey: SecKey) { self.privateKey = privateKey }

    func sign(_ value: String) throws -> Data {
        var error: Unmanaged<CFError>?
        guard let signature = SecKeyCreateSignature(
            privateKey,
            .ecdsaSignatureMessageX962SHA256,
            Data(value.utf8) as CFData,
            &error
        ) else {
            throw error!.takeRetainedValue() as Error
        }
        return signature as Data
    }

    static func verify(_ value: String, signature: Data, publicKey: SecKey) -> Bool {
        SecKeyVerifySignature(
            publicKey,
            .ecdsaSignatureMessageX962SHA256,
            Data(value.utf8) as CFData,
            signature as CFData,
            nil
        )
    }
}

final class EvaartaAuthenticatedSession {
    private let signer: EvaartaSecKeySessionSigner
    private let peerKey: SecKey
    private(set) var authenticated = false
    private var localNonce: String?

    init(privateKey: SecKey, peerKey: SecKey) {
        self.signer = EvaartaSecKeySessionSigner(privateKey: privateKey)
        self.peerKey = peerKey
    }

    func createHello(actorId: String, fingerprint: String) throws -> EvaartaSessionHello {
        let nonce = UUID().uuidString
        localNonce = nonce
        let payload = "(actorId)|(fingerprint)|(nonce)"
        return EvaartaSessionHello(
            actorId: actorId,
            fingerprint: fingerprint,
            nonce: nonce,
            signature: try signer.sign(payload)
        )
    }

    func accept(_ response: EvaartaSessionHello) throws {
        guard response.nonce == localNonce else {
            throw NSError(domain: "e-Vaarta", code: 2, userInfo: [NSLocalizedDescriptionKey: "session challenge mismatch"])
        }
        let payload = "(response.actorId)|(response.fingerprint)|(response.nonce)"
        guard EvaartaSecKeySessionSigner.verify(payload, signature: response.signature, publicKey: peerKey) else {
            throw NSError(domain: "e-Vaarta", code: 3, userInfo: [NSLocalizedDescriptionKey: "peer authentication failed"])
        }
        authenticated = true
    }

    func close() {
        localNonce = nil
        authenticated = false
    }
}
