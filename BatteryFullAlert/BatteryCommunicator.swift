//
//  BatteryCommunicator.swift
//  BatteryFullAlert
//
//  Created by Kevin Taniguchi on 4/20/18.
//  Copyright © 2018 Taniguchi. All rights reserved.
//

import Foundation

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
    }
}
