import Foundation
public struct EvaartaProviderBoundary:Sendable{public let provider:String;public let operations:Set<String>;public let secretRef:String?;public init(provider:String,operations:Set<String>,secretRef:String?=nil){self.provider=provider;self.operations=operations;self.secretRef=secretRef}}
public struct EvaartaNotificationRule:Sendable{public let id:String;public let channel:String;public let priority:Int;public let batchMinutes:Int;public let dedupeKey:String?;public init(id:String,channel:String,priority:Int,batchMinutes:Int=0,dedupeKey:String?=nil){self.id=id;self.channel=channel;self.priority=priority;self.batchMinutes=batchMinutes;self.dedupeKey=dedupeKey}}
public struct EvaartaMeetingWorkspace:Sendable{public let meetingId:String;public let sourceIds:[String];public let decisions:[String];public let actions:[String];public init(meetingId:String,sourceIds:[String],decisions:[String]=[],actions:[String]=[]){self.meetingId=meetingId;self.sourceIds=sourceIds;self.decisions=decisions;self.actions=actions}}
public enum EvaartaCommunicationCompletion{
 public static let providers=["imap","smtp","jmap","google","microsoft","matrix","slack","teams","whatsapp","telegram","zoom","webex","ringcentral","mattermost","signal","rcs"]
 public static let accessibility=["keyboard","screen-reader","reflow","text-scale","high-contrast","reduced-motion","touch","switch"]
 public static func aiGrounded(sourceIds:[String],citations:Set<String>)->Bool{sourceIds.isEmpty || sourceIds.contains(where:citations.contains)}
}