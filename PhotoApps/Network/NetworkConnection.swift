//
//  NetworkConnection.swift
//  PhotoApps
//
//  Created by Alexis on 2/11/22.
//

import Foundation
import Network

class NetworkConnection: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    @Published private(set) var connected: Bool?
    init() {
     checkConnection()
    }
    func checkConnection() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                        self.connected = true
                } else {
                        self.connected = false
                }
            }
        }
        monitor.start(queue: queue)
    }
}
