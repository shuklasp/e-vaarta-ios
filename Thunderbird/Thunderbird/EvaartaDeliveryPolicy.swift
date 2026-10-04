import Foundation
struct EvaartaDeliveryPolicy { static let localFirst=["wifi-lan","bluetooth","file-bundle","matrix","xmpp","whatsapp","arattai","email"]; static func shouldForward(_ envelope:EvaartaEnvelope)->Bool{envelope.hopLimit>0} }
