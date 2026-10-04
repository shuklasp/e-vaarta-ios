import Foundation

struct EvaartaWorkspaceSurfaceState { var selectedDocumentId:String?; var selectedItemId:String?; var query:String; var offlineReady:Bool=true }
struct EvaartaReaderSurfaceState { var documentId:String?; var mode:String="read"; var canAnnotate:Bool=true }
struct EvaartaEvidenceSurfaceState { var documentId:String?; var selectedGroupId:String? }
struct EvaartaAnnotationDraft { let documentId:String; let text:String; let start:Int; let end:Int }
struct EvaartaCollectionSurfaceState { var selectedCollectionId:String? }
struct EvaartaSearchHit { let type:String; let id:String; let title:String }
struct EvaartaOfflineSurfaceState { var pending:Int; var status:String="offline-ready" }
struct EvaartaTransferSurfaceState { let workspaceId:String?; let format:String="evaarta-workspace-json" }
struct EvaartaSyncSurfaceState { var status:String="local-only"; var networkEnabled:Bool=false }
struct EvaartaAccessibilitySurface { let landmarks=["navigation","main","complementary"]; let focusSearch="Command-K" }
