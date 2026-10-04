import Foundation
func normalizeEvaartaSelection(_ ids:[String],knownIds:Set<String>)->[String]{Array(NSOrderedSet(array:ids.filter{knownIds.contains($0)})) as? [String] ?? []}
func toggleEvaartaSelection(_ ids:[String],id:String,knownIds:Set<String>)->[String]{var s=Set(normalizeEvaartaSelection(ids,knownIds:knownIds));if !s.insert(id).inserted{s.remove(id)};return Array(s)}