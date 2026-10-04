import Foundation
import Network
import Security
import CoreBluetooth

struct EvaartaDiscoveredPeer: Hashable {
    let actorId: String
    let fingerprint: String
    let endpoint: NWEndpoint
}

final class EvaartaKeychainIdentityStore {
    private let service = "org.e-vaarta.identity"

    func loadOrCreatePrivateKey(account: String) throws -> SecKey {
        let tag = Data("(service).(account)".utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: tag,
            kSecReturnRef as String: true
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecSuccess, let key = item {
            return key as! SecKey
        }

        let attributes: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeECSECPrimeRandom,
            kSecAttrKeySizeInBits as String: 256,
            kSecPrivateKeyAttrs as String: [
                kSecAttrIsPermanent as String: true,
                kSecAttrApplicationTag as String: tag
            ]
        ]
        var error: Unmanaged<CFError>?
        guard let key = SecKeyCreateRandomKey(attributes as CFDictionary, &error) else {
            throw error!.takeRetainedValue() as Error
        }
        return key
    }
}

final class EvaartaBonjourTransport {
    private var listener: NWListener?

    func start(port: NWEndpoint.Port = .any, onConnection: @escaping (NWConnection) -> Void) throws -> NWEndpoint.Port {
        let listener = try NWListener(using: .tcp, on: port)
        listener.service = NWListener.Service(name: nil, type: "_evaarta._tcp", domain: nil, txtRecord: nil)
        listener.newConnectionHandler = { connection in
            onConnection(connection)
            connection.start(queue: .global())
        }
        listener.start(queue: .global())
        self.listener = listener
        guard let actualPort = listener.port else { throw NSError(domain: "e-Vaarta", code: 1) }
        return actualPort
    }

    func stop() {
        listener?.cancel()
        listener = nil
    }
}

final class EvaartaNWConnectionTransport {
    func send(_ data: Data, to endpoint: NWEndpoint) async throws {
        let connection = NWConnection(to: endpoint, using: .tcp)
        connection.start(queue: .global())
        try await withCheckedThrowingContinuation { continuation in
            connection.send(content: data, completion: .contentProcessed { error in
                if let error { continuation.resume(throwing: error) }
                else { continuation.resume() }
                connection.cancel()
            })
        }
    }
}

final class EvaartaBluetoothTransport: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    private(set) var central: CBCentralManager!
    private var discovered: [UUID: CBPeripheral] = [:]

    override init() {
        super.init()
        central = CBCentralManager(delegate: self, queue: nil)
    }

    func startScan(serviceUUIDs: [CBUUID]) {
        guard central.state == .poweredOn else { return }
        central.scanForPeripherals(withServices: serviceUUIDs)
    }

    func stopScan() {
        central.stopScan()
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {}
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any], rssi RSSI: NSNumber) {
        discovered[peripheral.identifier] = peripheral
    }
}
