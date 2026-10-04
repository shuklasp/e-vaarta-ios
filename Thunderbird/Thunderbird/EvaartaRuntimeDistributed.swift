import Foundation
struct EvaartaTrustedPeer:Hashable{let actorId:String;let publicKey:String;let fingerprint:String;var status:String="trusted"}
final class EvaartaTrustStore{private var peers:[String:EvaartaTrustedPeer]=[:];func trust(_ p:EvaartaTrustedPeer){peers[p.actorId]=p};func revoke(_ id:String){if var p=peers[id]{p.status="revoked";peers[id]=p}};func isTrusted(_ id:String)->Bool{peers[id]?.status=="trusted"}}
final class EvaartaPairingSession{private let trust:EvaartaTrustStore;private var peer:EvaartaTrustedPeer?;private(set)var state="idle";init(_ trust:EvaartaTrustStore){self.trust=trust};func begin(_ p:EvaartaTrustedPeer){peer=p;state="awaiting-user"};func approve(){guard let p=peer else{state="rejected";return};trust.trust(p);state="trusted"};func reject(){peer=nil;state="rejected"}}
struct EvaartaDeliveryReceipt{let messageId:String;let recipient:String;let status:String;let transport:String;let reason:String?}
