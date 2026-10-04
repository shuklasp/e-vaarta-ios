import Foundation
public struct EvaartaWorkspaceShell: Sendable { public var route:String; public var selection:String?; public var offline:Bool; public init(route:String="inbox",selection:String?=nil,offline:Bool=true){self.route=route;self.selection=selection;self.offline=offline} }
public struct EvaartaIdentity: Sendable { public let id:String; public let personId:String; public let type:String; public let value:String; public init(id:String,personId:String,type:String,value:String){self.id=id;self.personId=personId;self.type=type;self.value=value} }
public struct EvaartaAttachment: Sendable { public let id:String; public let hash:String; public let name:String; public let mime:String; public let size:Int64; public init(id:String,hash:String,name:String,mime:String,size:Int64){self.id=id;self.hash=hash;self.name=name;self.mime=mime;self.size=size} }
public enum EvaartaWorkspaceProduct {
 public static let routes=["inbox","conversation","person","document","evidence","meeting","decision","task","project","report","citation"]
 public static let semanticFlow=["communication","document","evidence","claim","finding","decision","task","project","report","citation","communication"]
 public static func navigate(_ shell:EvaartaWorkspaceShell,route:String,selection:String?=nil)->EvaartaWorkspaceShell?{guard routes.contains(route) else{return nil};return EvaartaWorkspaceShell(route:route,selection:selection,offline:shell.offline)}
 public static func identityMatch(_ a:EvaartaIdentity,_ b:EvaartaIdentity)->Bool{a.type.caseInsensitiveCompare(b.type)==.orderedSame && a.value.caseInsensitiveCompare(b.value)==.orderedSame}
 public static func dedupeAttachments(_ items:[EvaartaAttachment])->[EvaartaAttachment]{var seen=Set<String>();return items.filter{seen.insert($0.hash).inserted}}
 public static func aiGrounded(sourceIds:[String],citations:Set<String>)->Bool{sourceIds.isEmpty || sourceIds.contains(where:citations.contains)}
}