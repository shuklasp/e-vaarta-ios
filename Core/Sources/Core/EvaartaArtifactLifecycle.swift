import Foundation

public struct EvaartaArtifact:Sendable {
    public let id:String; public let type:String; public let name:String; public let mime:String; public let contentHash:String?; public let sourceId:String?; public let security:String; public let state:String
    public init(id:String,type:String,name:String="",mime:String="application/octet-stream",contentHash:String?=nil,sourceId:String?=nil,security:String="normal",state:String="active"){self.id=id;self.type=type;self.name=name;self.mime=mime;self.contentHash=contentHash;self.sourceId=sourceId;self.security=security;self.state=state}
}
public struct EvaartaArtifactRevision:Sendable { public let id:String; public let artifactId:String; public let contentHash:String; public let sourceId:String?; public init(id:String,artifactId:String,contentHash:String,sourceId:String?=nil){self.id=id;self.artifactId=artifactId;self.contentHash=contentHash;self.sourceId=sourceId} }
public struct EvaartaArtifactLink:Sendable { public let id:String; public let artifactId:String; public let targetType:String; public let targetId:String; public let type:String; public let revisionId:String?; public init(id:String,artifactId:String,targetType:String,targetId:String,type:String="attached",revisionId:String?=nil){self.id=id;self.artifactId=artifactId;self.targetType=targetType;self.targetId=targetId;self.type=type;self.revisionId=revisionId} }
public enum EvaartaArtifactLifecycle {
    public static let shareAllow="allow", shareWarn="warn", shareBlock="block", shareApprovalRequired="approval-required"
    public static func link(_ artifact:EvaartaArtifact,targetType:String,targetId:String,linkId:String,revisionId:String?=nil)->EvaartaArtifactLink { EvaartaArtifactLink(id:linkId,artifactId:artifact.id,targetType:targetType,targetId:targetId,revisionId:revisionId) }
    public static func forwardTaskArtifacts(_ links:[EvaartaArtifactLink],fromTaskId:String,toTaskId:String,artifactIds:Set<String>?=nil)->[EvaartaArtifactLink] { links.filter{$0.targetType=="task" && $0.targetId==fromTaskId && (artifactIds == nil || artifactIds!.contains($0.artifactId))}.map{EvaartaArtifactLink(id:"forward-"+$0.artifactId+"-"+toTaskId,artifactId:$0.artifactId,targetType:"task",targetId:toTaskId,type:$0.type,revisionId:$0.revisionId)} }
    public static func shareDecision(_ artifact:EvaartaArtifact,recipientType:String,allowRestrictedExternal:Bool=false)->String {
        if artifact.state=="blocked" || artifact.state=="quarantined" { return shareBlock }
        if artifact.security=="restricted" && recipientType=="external" { return allowRestrictedExternal ? shareApprovalRequired : shareBlock }
        if artifact.security=="confidential" && recipientType=="external" { return shareWarn }
        return shareAllow
    }
    public static let contract=["stable-artifact-identity","content-hash","reusable-references","task-propagation","communication-sharing","evidence-linking","revision-aware","provenance","security-policy","offline-first"]
}
