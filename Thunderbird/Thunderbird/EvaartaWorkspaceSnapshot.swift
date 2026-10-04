import Foundation
struct EvaartaWorkspaceSnapshot:Codable{let workspaceId:String;let revision:Int;let name:String;let documentCount:Int;let itemCount:Int;let evidenceGroupCount:Int;let updatedAt:Date}
extension EvaartaDocumentWorkspace{func snapshot(revision:Int=0)->EvaartaWorkspaceSnapshot{EvaartaWorkspaceSnapshot(workspaceId:id,revision:revision,name:name,documentCount:documents.count,itemCount:items.count,evidenceGroupCount:evidenceGroups.count,updatedAt:updatedAt)}}
