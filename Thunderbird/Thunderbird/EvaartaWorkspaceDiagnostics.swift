import Foundation
struct EvaartaDiagnosticResult{let healthy:Bool;let errors:Int;let warnings:Int}
enum EvaartaWorkspaceDiagnostics{static func inspect(_ workspace:EvaartaDocumentWorkspace)->EvaartaDiagnosticResult{let ids=workspace.documents.map(\.id);let unique=Set(ids);let orphaned=workspace.items.filter{item in guard let d=item.anchor?.documentId else{return false};return !unique.contains(d)}.count;return EvaartaDiagnosticResult(healthy:ids.count==unique.count,errors:ids.count-unique.count,warnings:orphaned)}}
