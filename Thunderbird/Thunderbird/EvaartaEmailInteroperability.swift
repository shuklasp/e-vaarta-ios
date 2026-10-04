import Foundation
protocol EvaartaMailInteroperability {
 func export(destination:String,payload:Data) async throws
 func importMessages() async throws -> [Data]
}
