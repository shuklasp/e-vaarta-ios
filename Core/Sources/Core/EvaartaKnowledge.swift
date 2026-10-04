import Foundation

public struct EvaartaEvidenceRef: Codable, Equatable, Sendable {
    public let id: String
    public let sourceId: String?
    public let anchor: String?
    public init(id: String, sourceId: String? = nil, anchor: String? = nil) { self.id=id; self.sourceId=sourceId; self.anchor=anchor }
}
public struct EvaartaClaim: Codable, Equatable, Sendable {
    public let id: String
    public let text: String
    public let evidenceIds: [String]
    public init(id:String,text:String,evidenceIds:[String]=[]) { self.id=id; self.text=text; self.evidenceIds=evidenceIds }
}
public struct EvaartaGroundedAnswer: Codable, Equatable, Sendable {
    public let answer: String
    public let claims: [EvaartaClaim]
    public let evidence: [EvaartaEvidenceRef]
    public var grounded: Bool { let ids=Set(evidence.map(\.id)); return claims.allSatisfy { $0.evidenceIds.allSatisfy(ids.contains) } }
    public init(answer:String,claims:[EvaartaClaim],evidence:[EvaartaEvidenceRef]) { self.answer=answer; self.claims=claims; self.evidence=evidence }
}
public struct EvaartaTask: Codable, Equatable, Sendable {
    public let id:String; public let title:String; public let dependsOn:[String]; public let duration:Int; public let status:String
    public init(id:String,title:String,dependsOn:[String]=[],duration:Int=1,status:String="todo") { self.id=id; self.title=title; self.dependsOn=dependsOn; self.duration=duration; self.status=status }
}
public enum EvaartaTaskGraph {
    public static func isValid(_ tasks:[EvaartaTask]) -> Bool {
        let byId=Dictionary(uniqueKeysWithValues: tasks.map{($0.id,$0)}); var visiting=Set<String>(); var visited=Set<String>()
        func dfs(_ id:String)->Bool {
            if visiting.contains(id){return false}; if visited.contains(id){return true}; guard let t=byId[id] else{return false}
            visiting.insert(id); if t.dependsOn.contains(where:{!dfs($0)}){return false}; visiting.remove(id); visited.insert(id); return true
        }
        return tasks.allSatisfy{dfs($0.id)}
    }
}
