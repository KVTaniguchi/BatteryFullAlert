//
//  ViewController.swift
//  BatteryFullAlert
//
//  Created by Kevin Taniguchi on 4/20/18.
//  Copyright © 2018 Taniguchi. All rights reserved.
//

import UIKit

class BatteryAlertViewController: UIViewController {
    private let currentBatteryLabel = UILabel()
    private let notificationsAllowedLabel = UILabel()
    private let batteryStateLabel = UILabel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: .UIDeviceBatteryLevelDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateDidChange), name: .UIDeviceBatteryStateDidChange, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Battery Alert"
        view.backgroundColor = .white
        
        currentBatteryLabel.text = BatteryMonitor.shared.batteryChargeLevelMessage
        notificationsAllowedLabel.text = "Notifications are allowed?"
        batteryStateLabel.text = BatteryMonitor.shared.batteryStateMessage
        
        let customNotifyLabel = UILabel()
        customNotifyLabel.text = "Notify at ?"
        let customNotifySwitch = UISwitch()
        let fullBatteryNotifyLabel = UILabel()
        fullBatteryNotifyLabel.text = "Notify me at 100%"
        let fullBatteryNotifySwitch = UISwitch()
        
        let notifySwitchSV = UIStackView(arrangedSubviews: [fullBatteryNotifySwitch, customNotifySwitch])
        notifySwitchSV.axis = .vertical
        notifySwitchSV.spacing = 20
        let notifyLabelSV = UIStackView(arrangedSubviews: [fullBatteryNotifyLabel, customNotifyLabel])
        notifyLabelSV.axis = .vertical
        notifyLabelSV.spacing = 20
        
        let notifySV = UIStackView(arrangedSubviews: [notifyLabelSV, notifySwitchSV])
        
        let fullSV = UIStackView(arrangedSubviews: [currentBatteryLabel, batteryStateLabel, notificationsAllowedLabel, notifySV])
        fullSV.axis = .vertical
        fullSV.spacing = 30
        
        fullSV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fullSV)
        
        fullSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        fullSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        fullSV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        fullSV.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        
        // button to enable notifications
        // toggle notify me at 100
        // toogle notify me at ____ level
    }
    
    @objc func batteryLevelDidChange() {
        currentBatteryLabel.text = BatteryMonitor.shared.batteryChargeLevelMessage
    }
    
    @objc func batteryStateDidChange() {
        batteryStateLabel.text = BatteryMonitor.shared.batteryStateMessage
    }
}

