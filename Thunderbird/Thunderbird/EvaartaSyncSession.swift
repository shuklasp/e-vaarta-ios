import Foundation
enum EvaartaSyncSessionState{case idle,discovering,comparing,conflict,ready,committed,failed}
struct EvaartaSyncSession{let id:String;let workspaceId:String;let deviceId:String;var state:EvaartaSyncSessionState=.idle;var error:String?}