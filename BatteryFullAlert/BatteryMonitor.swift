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
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: .UIDeviceBatteryLevelDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateDidChange), name: .UIDeviceBatteryStateDidChange, object: nil)
    }
    
    func startMonitoring() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    var batteryLevel: Float {
        return UIDevice.current.batteryLevel
    }
    
    var batteryState: UIDeviceBatteryState {
        return UIDevice.current.batteryState
    }
    
    @objc func batteryLevelDidChange() {
        
    }
    
    @objc func batteryStateDidChange(_ notification: Notification) {
        switch batteryState {
        case .unplugged, .unknown:
            print("not charging")
        case .charging:
            print("charging")
        case .full:
            print("full")
        }
    }
}
