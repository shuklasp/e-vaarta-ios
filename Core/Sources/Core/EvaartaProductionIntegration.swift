import Foundation

public struct EvaartaCredentialReference:Sendable{public let provider:String;public let accountId:String;public let secretRef:String?;public init(provider:String,accountId:String,secretRef:String?=nil){self.provider=provider;self.accountId=accountId;self.secretRef=secretRef}}
public struct EvaartaCapabilityToken:Sendable{public let subject:String;public let capability:String;public let resource:String;public let expiresAt:Date?;public let nonce:String;public init(subject:String,capability:String,resource:String,expiresAt:Date?=nil,nonce:String){self.subject=subject;self.capability=capability;self.resource=resource;self.expiresAt=expiresAt;self.nonce=nonce}}
public enum EvaartaProductionIntegration{
 public static func authorize(_ token:EvaartaCapabilityToken,required:String,resource:String,now:Date=Date())->Bool{token.capability==required && token.resource==resource && (token.expiresAt == nil || token.expiresAt! > now)}
 public static func credential(provider:String,accountId:String,secretRef:String?=nil)->EvaartaCredentialReference{EvaartaCredentialReference(provider:provider,accountId:accountId,secretRef:secretRef)}
 public static let contract=["offline-first","ui-projections","provider-adapters","calendar-adapters","credential-isolation","capability-authorization","audit","release-validation"]
}
