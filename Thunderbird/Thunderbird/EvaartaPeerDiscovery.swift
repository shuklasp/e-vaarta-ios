import Foundation
struct EvaartaPeer:Hashable { let peerId:String; let transport:String; let identityHint:String? }
protocol EvaartaPeerDiscoveryProvider { func isAvailable()->Bool; func discover() async throws -> [EvaartaPeer] }
final class EvaartaPeerDiscovery { private let providers:[EvaartaPeerDiscoveryProvider]; init(_ providers:[EvaartaPeerDiscoveryProvider]){self.providers=providers}; func discover() async throws -> [EvaartaPeer]{var out:[EvaartaPeer]=[];for p in providers where p.isAvailable(){out += try await p.discover()};return Array(Set(out))} }
