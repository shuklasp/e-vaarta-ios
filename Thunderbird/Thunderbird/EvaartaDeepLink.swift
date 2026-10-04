import Foundation
struct EvaartaDeepLink{let workspaceId:String;let documentId:String?;let itemId:String?}
enum EvaartaDeepLinks{static func parse(_ url:URL)->EvaartaDeepLink?{guard url.scheme=="evaarta",url.host=="workspace" else{return nil};let raw=String(url.path.dropFirst());guard !raw.isEmpty else{return nil};let components=URLComponents(url:url,resolvingAgainstBaseURL:false);let q=components?.queryItems ?? [];return EvaartaDeepLink(workspaceId:raw.removingPercentEncoding ?? raw,documentId:q.first{$0.name=="document"}?.value,itemId:q.first{$0.name=="item"}?.value)}}
