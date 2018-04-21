//
//  BatteryMonitor.swift
//  BatteryFullAlert
//
//  Created by Kevin Taniguchi on 4/20/18.
//  Copyright © 2018 Taniguchi. All rights reserved.
//

import Foundation
import UIKit

class BatteryMonitor {
    static let shared = BatteryMonitor()
    
    private init() {}
    
    func startMonitoring() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    var batteryChargeLevelMessage: String {
        return "Battery: \(batteryLevel)%"
    }
    
    var batteryStateMessage: String {
        switch batteryState {
        case .unplugged:
            return "Unplugged"
        case .unknown:
            return "Unknown"
        case .charging:
            return "Charging"
        case .full:
            return "Full"
        }
    }
    
    var batteryLevel: Float {
        return UIDevice.current.batteryLevel * 100.0
    }
    
    var batteryState: UIDeviceBatteryState {
        return UIDevice.current.batteryState
    }
}
