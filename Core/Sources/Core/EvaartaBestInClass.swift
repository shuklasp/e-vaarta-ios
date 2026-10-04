import Foundation

public enum EvaartaPdfViewMode: String, Codable, Sendable { case page, continuous, twoPage, twoPageContinuous, fitWidth, fitPage, reading, presentation }
public enum EvaartaReadingTheme: String, Codable, Sendable { case light, dark, sepia, highContrast, system }

public struct EvaartaPdfReaderState: Codable, Equatable, Sendable {
    public let documentId: String?
    public let pageCount: Int
    public let currentPage: Int
    public let viewMode: EvaartaPdfViewMode
    public let zoom: Double
    public let rotation: Int
    public let theme: EvaartaReadingTheme
    public let readingOffset: Double
    public init(documentId:String?=nil,pageCount:Int=0,currentPage:Int=1,viewMode:EvaartaPdfViewMode=.continuous,zoom:Double=1,rotation:Int=0,theme:EvaartaReadingTheme=.system,readingOffset:Double=0) {
        self.documentId=documentId; self.pageCount=pageCount; self.currentPage=currentPage; self.viewMode=viewMode; self.zoom=zoom; self.rotation=rotation; self.theme=theme; self.readingOffset=readingOffset
    }
}

public struct EvaartaPdfAnchor: Codable, Equatable, Sendable {
    public let documentId: String
    public let revisionId: String?
    public let page: Int
    public let pageLabel: String?
    public let text: String
    public let textStart: Int?
    public let textEnd: Int?
    public let structurePath: [String]
    public init(documentId:String,revisionId:String?=nil,page:Int,pageLabel:String?=nil,text:String="",textStart:Int?=nil,textEnd:Int?=nil,structurePath:[String]=[]) {
        self.documentId=documentId; self.revisionId=revisionId; self.page=page; self.pageLabel=pageLabel; self.text=text; self.textStart=textStart; self.textEnd=textEnd; self.structurePath=structurePath
    }
}

public struct EvaartaPdfEvidence: Codable, Equatable, Sendable {
    public let anchor: EvaartaPdfAnchor
    public let quote: String
    public let context: String
    public let confidence: Double
    public let extractionMethod: String
    public init(anchor:EvaartaPdfAnchor,quote:String,context:String="",confidence:Double=1,extractionMethod:String="native") {
        self.anchor=anchor; self.quote=quote; self.context=context; self.confidence=confidence; self.extractionMethod=extractionMethod
    }
}

public struct EvaartaKnowledgeBlock: Codable, Equatable, Sendable {
    public let id:String; public let type:String; public let text:String; public let properties:[String:String]
    public init(id:String,type:String="paragraph",text:String="",properties:[String:String]=[:]) { self.id=id; self.type=type; self.text=text; self.properties=properties }
}

public struct EvaartaAutomation: Codable, Equatable, Sendable {
    public let id:String; public let trigger:String; public let conditions:[String]; public let action:String; public let requiredCapabilities:[String]
    public init(id:String,trigger:String,conditions:[String]=[],action:String,requiredCapabilities:[String]=[]) { self.id=id; self.trigger=trigger; self.conditions=conditions; self.action=action; self.requiredCapabilities=requiredCapabilities }
}

public struct EvaartaAccessibilityProfile: Codable, Equatable, Sendable {
    public let screenReader:Bool; public let keyboard:Bool; public let reflow:Bool; public let highContrast:Bool; public let textScale:Double; public let reducedMotion:Bool
    public init(screenReader:Bool=true,keyboard:Bool=true,reflow:Bool=true,highContrast:Bool=false,textScale:Double=1,reducedMotion:Bool=false) {
        self.screenReader=screenReader; self.keyboard=keyboard; self.reflow=reflow; self.highContrast=highContrast; self.textScale=textScale; self.reducedMotion=reducedMotion
    }
}

public enum EvaartaBestInClass {
    public static func validPdfState(_ state:EvaartaPdfReaderState)->Bool {
        state.pageCount >= 0 && state.currentPage >= 1 && (state.pageCount == 0 || state.currentPage <= state.pageCount) && (0.25...8).contains(state.zoom) && (0...359).contains(state.rotation)
    }
    public static func groundedEvidence(_ evidence:EvaartaPdfEvidence)->Bool {
        !evidence.anchor.documentId.isEmpty && evidence.anchor.page > 0 && (0...1).contains(evidence.confidence)
    }
}
