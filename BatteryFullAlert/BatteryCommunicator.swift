//
//  BatteryCommunicator.swift
//  BatteryFullAlert
//
//  Created by Kevin Taniguchi on 4/20/18.
//  Copyright © 2018 Taniguchi. All rights reserved.
//

import Foundation
import UIKit

enum KVNetworkError: Error {
    case failedJSONBodyEncode
    case noResponse
}

class BatteryCommunicator {
    static let shared = BatteryCommunicator()
    
    private init() {}
    
    func updateRemote() {
        // when the app backgrounds
        /*
         - get the current battery level
         - send this to a remote server
         - on server - estimate the time it takes to recharge from that level
         - once that time is up send a push to the device to wake it up
         - when device wakes up -
         - check state -
         */
        let currentBattery = BatteryMonitor.shared.batteryLevel
        let currentDeviceUUID = UIDevice.current.identifierForVendor
        let currentDeviceModel = UIDevice.current.modelName
        
        
        print(currentBattery)
        print(currentDeviceUUID?.uuidString ?? "")
        print(currentDeviceModel)
        // post to service with device type

        // https://www.somethingsomething/api/batteryUpdate/create
        guard let url = URL(string: "") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = ["batteryLevel": Double(currentBattery),
                                         "deviceType": currentDeviceModel.rawValue,
                                         "deviceID": currentDeviceUUID?.uuidString ?? "",
                                         "desiredCharge": 100.0]
        
        guard let body = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request).resume()
    }
}

enum KVDeviceType: Int {
    case iPhone5c
    case iPhone5s
    case iPhoneSE
    case iPhone6
    case iPhone6Plus
    case iPhone6S
    case iPhone6SPlus
    
    case iPhone7
    case iPhone7Plus
    
    case iPhone8
    case iPhone8Plus
    
    case iPhoneX
    
    case unsupported
}

extension UIDevice {
    
    var modelName: KVDeviceType {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPhone5,3", "iPhone5,4":                  return .iPhone5c
        case "iPhone6,1", "iPhone6,2":                  return .iPhone5s
        case "iPhone8,4":                               return .iPhoneSE
        case "iPhone7,2":                               return .iPhone6
        case "iPhone7,1":                               return .iPhone6Plus
        case "iPhone8,1":                               return .iPhone6S
        case "iPhone8,2":                               return .iPhone6SPlus
        case "iPhone9,1", "iPhone9,3":                  return .iPhone7
        case "iPhone9,2", "iPhone9,4":                  return .iPhone7Plus
        
        case "iPhone10,1", "iPhone10,4":                return .iPhone8
        case "iPhone10,2", "iPhone10,5":                return .iPhone8Plus
        case "iPhone10,3", "iPhone10,6":                return .iPhoneX
        default:                                        return .unsupported
        }
    }
    
}
