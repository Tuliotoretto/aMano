//
//  NetworkMonitor.swift
//  aMano
//
//  Created by Julian Garcia  on 30/01/23.
//

import Foundation
import UIKit
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    public func showNetworkAlert(_ viewController: UIViewController) {
        let alert = UIAlertController(
            title: "No hay conexión a internet",
            message: "Revisa tu conexión a internet o intentalo más tarde",
            preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Continuar", style: .default)
        
        alert.addAction(ok)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
