import Foundation

public enum EvaartaCaptureType: String, Codable, Sendable { case camera, scan, voice, photo }
public enum EvaartaAiLocality: String, Codable, Sendable { case local, remote, hybrid }

public struct EvaartaPdfProductionRequest: Codable, Equatable, Sendable { public let operation:String; public let payload:[String:String]; public init(operation:String,payload:[String:String]=[:]){self.operation=operation;self.payload=payload}}
public struct EvaartaResearchCard: Codable, Equatable, Sendable { public let id:String; public let sourceId:String; public let anchor:String; public let text:String; public let note:String; public init(id:String,sourceId:String,anchor:String,text:String="",note:String=""){self.id=id;self.sourceId=sourceId;self.anchor=anchor;self.text=text;self.note=note}}
public struct EvaartaScholarlyRecord: Codable, Equatable, Sendable { public let id:String; public let title:String; public let doi:String?; public let authors:[String]; public let year:Int?; public init(id:String,title:String="",doi:String?=nil,authors:[String]=[],year:Int?=nil){self.id=id;self.title=title;self.doi=doi;self.authors=authors;self.year=year}}
public struct EvaartaMarkdownDocument: Codable, Equatable, Sendable { public let id:String; public let path:String; public let markdown:String; public let properties:[String:String]; public let revisionId:String?; public init(id:String,path:String,markdown:String="",properties:[String:String]=[:],revisionId:String?=nil){self.id=id;self.path=path;self.markdown=markdown;self.properties=properties;self.revisionId=revisionId}}
public struct EvaartaAiProvider: Codable, Equatable, Sendable { public let id:String; public let locality:EvaartaAiLocality; public let capabilities:[String]; public let model:String?; public init(id:String,locality:EvaartaAiLocality,capabilities:[String]=[],model:String?=nil){self.id=id;self.locality=locality;self.capabilities=capabilities;self.model=model}}
public struct EvaartaGroundedAiRequest: Codable, Equatable, Sendable { public let query:String; public let sourceIds:[String]; public let evidenceIds:[String]; public let action:String?; public init(query:String,sourceIds:[String]=[],evidenceIds:[String]=[],action:String?=nil){self.query=query;self.sourceIds=sourceIds;self.evidenceIds=evidenceIds;self.action=action}}
public struct EvaartaSemanticEvent: Codable, Equatable, Sendable { public let id:String; public let actorId:String; public let lamport:Int64; public let objectId:String; public let type:String; public let payload:[String:String]; public let baseRevision:String?; public init(id:String,actorId:String,lamport:Int64,objectId:String,type:String,payload:[String:String]=[:],baseRevision:String?=nil){self.id=id;self.actorId=actorId;self.lamport=lamport;self.objectId=objectId;self.type=type;self.payload=payload;self.baseRevision=baseRevision}}
public struct EvaartaConflict: Codable, Equatable, Sendable { public let objectId:String; public let baseRevision:String?; public let local:String; public let remote:String; public let reason:String; public let resolution:String?; public init(objectId:String,baseRevision:String?,local:String,remote:String,reason:String="concurrent-update",resolution:String?=nil){self.objectId=objectId;self.baseRevision=baseRevision;self.local=local;self.remote=remote;self.reason=reason;self.resolution=resolution}}
public struct EvaartaCapture: Codable, Equatable, Sendable { public let id:String; public let type:EvaartaCaptureType; public let uri:String; public let sourceId:String?; public let transcript:String?; public let ocrText:String?; public init(id:String,type:EvaartaCaptureType,uri:String,sourceId:String?=nil,transcript:String?=nil,ocrText:String?=nil){self.id=id;self.type=type;self.uri=uri;self.sourceId=sourceId;self.transcript=transcript;self.ocrText=ocrText}}

public enum EvaartaAdvancedContracts {
    public static func validProduction(_ value:EvaartaPdfProductionRequest)->Bool { !value.operation.isEmpty }
    public static func validResearch(_ value:EvaartaResearchCard)->Bool { !value.id.isEmpty && !value.sourceId.isEmpty && !value.anchor.isEmpty }
    public static func validCitation(_ value:EvaartaScholarlyRecord)->Bool { !value.id.isEmpty }
    public static func validMarkdown(_ value:EvaartaMarkdownDocument)->Bool { !value.id.isEmpty && !value.path.isEmpty }
    public static func validAiRequest(_ value:EvaartaGroundedAiRequest)->Bool { !value.query.isEmpty }
    public static func validEvent(_ value:EvaartaSemanticEvent)->Bool { !value.id.isEmpty && !value.actorId.isEmpty && !value.objectId.isEmpty && value.lamport >= 0 }
    public static func validCapture(_ value:EvaartaCapture)->Bool { !value.id.isEmpty && !value.uri.isEmpty }
}
