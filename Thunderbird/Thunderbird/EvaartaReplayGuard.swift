import Foundation
final class EvaartaReplayGuard { private var ids=Set<String>(); private let max:Int; init(max:Int=10000){self.max=max}; func seen(_ id:String)->Bool{ids.contains(id)}; func accept(_ id:String)->Bool{guard !ids.contains(id) else{return false};ids.insert(id);if ids.count>max,let first=ids.first{ids.remove(first)};return true} }
