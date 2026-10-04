import Foundation
public struct EvaartaTask: Sendable {
 public let id:String; public var title:String; public var status:String; public var priority:String
 public var assigneeId:String?; public var teamId:String?; public var dependsOn:[String]
 public var estimateMinutes:Int; public var actualMinutes:Int; public var remainingMinutes:Int
 public var evidenceIds:[String]; public var decisionIds:[String]; public var sourceIds:[String]
 public init(id:String,title:String,status:String="inbox",priority:String="medium",assigneeId:String?=nil,teamId:String?=nil,dependsOn:[String]=[],estimateMinutes:Int=0,actualMinutes:Int=0,remainingMinutes:Int?=nil,evidenceIds:[String]=[],decisionIds:[String]=[],sourceIds:[String]=[]){self.id=id;self.title=title;self.status=status;self.priority=priority;self.assigneeId=assigneeId;self.teamId=teamId;self.dependsOn=dependsOn;self.estimateMinutes=estimateMinutes;self.actualMinutes=actualMinutes;self.remainingMinutes=remainingMinutes ?? estimateMinutes;self.evidenceIds=evidenceIds;self.decisionIds=decisionIds;self.sourceIds=sourceIds}
}
public struct EvaartaAssignment: Sendable { public let mode:String; public let assigneeId:String?; public let teamId:String?; public let rationale:String?; public let state:String
 public init(mode:String="direct",assigneeId:String?=nil,teamId:String?=nil,rationale:String?=nil,state:String="pending"){self.mode=mode;self.assigneeId=assigneeId;self.teamId=teamId;self.rationale=rationale;self.state=state}}
public struct EvaartaTaskHealth: Sendable { public let health:String; public let overdue:Bool; public let stalled:Bool; public let unassigned:Bool }
public enum EvaartaTaskWorkManagement {
 public static let statuses=["inbox","planned","ready","assigned","accepted","in-progress","waiting","blocked","review","approved","done","cancelled","deferred","rejected","duplicate"]
 public static func assign(_ t:EvaartaTask,_ a:EvaartaAssignment)->EvaartaTask { var x=t;x.assigneeId=a.assigneeId;x.teamId=a.teamId;if a.assigneeId != nil || a.teamId != nil{x.status="assigned"};return x }
 public static func accept(_ t:EvaartaTask,_ accepted:Bool)->EvaartaTask { var x=t;x.status=accepted ? "accepted":"rejected";return x }
 public static func validateGraph(_ tasks:[EvaartaTask])->Bool { let ids=Set(tasks.map{$0.id});var visiting=Set<String>();var visited=Set<String>()
   func dfs(_ id:String)->Bool { if visiting.contains(id){return false};if visited.contains(id){return true};guard let t=tasks.first(where:{$0.id==id}) else{return false};visiting.insert(id);for d in t.dependsOn{if !dfs(d){return false}};visiting.remove(id);visited.insert(id);return true };return tasks.allSatisfy{dfs($0.id)}
 }
 public static func monitor(_ t:EvaartaTask,now:Date=Date(),updated:Date=Date(),due:Date?=nil,staleHours:Double=72)->EvaartaTaskHealth {let un=t.assigneeId==nil && t.teamId==nil;let stale=now.timeIntervalSince(updated)>=staleHours*3600;let overdue=due != nil && now > due! && t.status != "done";let h=un ? "unassigned" : t.status=="blocked" ? "blocked" : stale ? "stalled" : overdue ? "late":"on-track";return EvaartaTaskHealth(health:h,overdue:overdue,stalled:stale,unassigned:un)}
}
