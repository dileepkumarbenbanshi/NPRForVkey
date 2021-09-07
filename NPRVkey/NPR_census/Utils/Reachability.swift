//
//  Reachability.swift
//  NPR-2021
//
//  Created by Dileep on 03/04/21.
//  Copyright © 2021 admin. All rights reserved.
//



import Foundation
import SystemConfiguration
import Network
import Foundation
import SystemConfiguration

final class Reachability {
   
    
    
    let monitor : NWPathMonitor
    private let queue = DispatchQueue.global()
    public private(set) var isConnected : Bool = false
    static let shared = Reachability()
    private init() {
        monitor = NWPathMonitor()
    }
    
    
    
   

       
        private var status: NWPath.Status = .requiresConnection
        var isReachable: Bool { status == .satisfied }
        var isReachableOnCellular: Bool = true

        func startMonitoring() {
           
            monitor.start(queue: queue)
            monitor.pathUpdateHandler = { [weak self] path in
                self?.status = path.status
                self?.isReachableOnCellular = path.isExpensive
                self?.isConnected = path.status == .satisfied

                
                print(path.isExpensive)
            }

            
        }

        func stopMonitoring() {
            monitor.cancel()
        }
    }
    
    

