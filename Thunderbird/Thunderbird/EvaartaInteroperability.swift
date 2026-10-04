import Foundation

enum EvaartaWireCodec {
 static func encode(_ value: [String: Any]) throws -> Data { try JSONSerialization.data(withJSONObject: value) }
 static func decode(_ data: Data) throws -> [String: Any] { try JSONSerialization.jsonObject(with: data) as! [String: Any] }
 static func b64(_ data: Data)->String { data.base64EncodedString() }
 static func unb64(_ value:String)->Data { Data(base64Encoded:value) ?? Data() }
}
struct EvaartaAttachmentAck {
 let attachmentId:String
 let received:Set<Int>
 func missing(total:Int)->[Int]{(0..<total).filter{!received.contains($0)}}
}
final class EvaartaInteroperabilityReceiver {
 private let trust:EvaartaTrustStore
 init(trust:EvaartaTrustStore){self.trust=trust}
 func assertPeer(_ peer:EvaartaTrustedPeer)throws{
  guard trust.isTrusted(peer.actorId) else {throw NSError(domain:"e-Vaarta",code:30)}
 }
}
