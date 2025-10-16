//
//  Device_ManagedObject.swift
//  BleWifiScan
//
//  Created by Pavel Mac on 10/15/25.
//

import Foundation
import CoreData

@objc(Device_ManagedObject)

class Device_ManagedObject: NSManagedObject {
    
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var givenName: String
    @NSManaged var isTracking: Bool
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var user_id: String
    @NSManaged var lastScanned: Date?
}
