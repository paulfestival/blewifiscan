//
//  ErrorManager.swift
//  BleWifiScan
//
//  Created by Pavel Mac on 10/15/25.
//

import Foundation

struct Alert {
    let title: String
    let message: String
}

class AlertManager {
    static var alertQueue: Observable<[Alert]> = Observable<[Alert]>([])
  
    static func queue(alert: Alert) {
        alertQueue.value.removeAll()
        alertQueue.value.append(alert)
    }
}
