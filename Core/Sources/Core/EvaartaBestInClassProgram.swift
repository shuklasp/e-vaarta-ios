import Foundation
public enum EvaartaProductClass:String,CaseIterable,Codable,Sendable{case communication,pdfReader="pdf-reader",pdfProduction="pdf-production",documents,research,knowledge,citations,search,ocr,ai,projects,tasks,meetings,calendar,automation,collaboration,evidence,accessibility,offline,security,privacy,interoperability,mobile,governance,reporting}
public enum EvaartaBestInClassProgram{
 public static let principles=["one-semantic-graph","evidence-before-assertion","revision-aware-provenance","offline-first","local-first-privacy","explicit-permissions","auditable-automation","loss-report","accessibility-gate","benchmark-before-claim"]
 public static var classes:[String]{EvaartaProductClass.allCases.map{$0.rawValue}}
 public static func requiresHumanAndAdversarial(evidenceCount:Int,human:Bool,adversarial:Bool)->Bool{evidenceCount>0&&human&&adversarial}
}