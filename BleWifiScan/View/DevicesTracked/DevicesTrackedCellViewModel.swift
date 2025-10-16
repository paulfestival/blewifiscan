//
//  DevicesTrackedCellViewModel.swift
//  BleWifiScan
//
//  Created by Pavel Mac on 10/14/25.
//

import Foundation

class DevicesTrackedCellViewModel {
    let device: Device!
    let deviceName: String!
    let lastScannedString: String!
    
    init(device: Device) {
        self.device = device
        self.deviceName = device.name
        
        if let lastScannedDate = self.device.lastScanned {
            self.lastScannedString = "\(lastScannedDate.timeSinceDate(fromDate: Date()))"
        } else {
            self.lastScannedString = "unknown"
        }
    }
}
