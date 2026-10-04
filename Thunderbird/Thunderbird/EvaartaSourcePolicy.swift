import Foundation
enum EvaartaSourceOpenMode{case offline,external,unavailable}
struct EvaartaSourceOpenResult{let mode:EvaartaSourceOpenMode;let reference:String?}
func evaartaSourceOpenPolicy(document:EvaartaDocument,offlineReference:String?=nil)->EvaartaSourceOpenResult{if let path=offlineReference{return EvaartaSourceOpenResult(mode:.offline,reference:path)};if let ref=document.sourceRef{return EvaartaSourceOpenResult(mode:.external,reference:ref)};return EvaartaSourceOpenResult(mode:.unavailable,reference:nil)}
