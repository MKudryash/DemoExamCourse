//
//  CheckConnectNetwork.swift
//  DemoExamCourse
//
//  Created by user on 12.10.2024.
//

import Foundation
import Network


final class CheckConnectNetwork {
    @Published var isConnected: Bool = true
    
    static let instance = CheckConnectNetwork()

    private let networkMonitor = NWPathMonitor()

    private let queue = DispatchQueue(label: "NetworkQueue")

    init() {
        networkMonitor.pathUpdateHandler = { path in
            let isConnected = path.status == .satisfied
            
            DispatchQueue.main.async {
                self.isConnected = isConnected
            }
        }
        networkMonitor.start(queue: queue)
    }
}
