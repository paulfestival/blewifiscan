//
//  BluetoothManager.swift
//  BleWifiScan
//
//  Created by Pavel Mac on 10/16/25.
//

import Foundation
import CoreBluetooth

struct Peripheral: Equatable {
    let peripheral: CBPeripheral
    let rssi: NSNumber
  
    static func == (lhs: Peripheral, rhs: Peripheral) -> Bool {
        return lhs.peripheral.identifier == rhs.peripheral.identifier
    }
}

protocol BluetoothManagerDelegate {
    func didUpdateDevices()
}

class BluetoothManager: NSObject {
    var centralManager: CBCentralManager!
    var peripherals: [Peripheral] = []
    var txPower: Double?
    
    var delegate: BluetoothManagerDelegate?
    
    override init() {
        super.init()
      
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScan() {
        peripherals = []
        getConnectedPeriperals()
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func stopScan() {
        centralManager.stopScan()
    }
    
    func getConnectedPeriperals() {
        let connected = centralManager.retrieveConnectedPeripherals(withServices: [CBUUID(string: "0x1800")])
      
        for peripheral in connected {
            print("BleWifiScan connected to \(peripheral)")
        }
    }
    
    func getDevices() -> [Device] {
      
        var devices: [Device] = []
      
        for peripheral in peripherals {
            devices.append(Device(id: peripheral.peripheral.identifier, name: peripheral.peripheral.name ?? "unknown", rssi: Int(truncating: peripheral.rssi), isTracking: nil, givenName: nil, location: nil, user_id: nil))
        }
      
        return devices
    }
}


extension BluetoothManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("BleWiFiScan central.state is .unknown")
        case .resetting:
            print("BleWiFiScan central.state is .resetting")
        case .unsupported:
            print("BleWiFiScan central.state is .unsupported")
        case .unauthorized:
            print("BleWiFiScan central.state is .unauthorized")
        case .poweredOff:
            print("BleWiFiScan central.state is .poweroff")
        case .poweredOn:
            print("BleWiFiScan central.state is .poweredOn")
            
            centralManager.scanForPeripherals(withServices: nil)
            
        @unknown default:
            print("BleWiFiScan central.state is .unknown default")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
      
        print(peripheral)
        print(advertisementData)
        print(RSSI)
        
        if let power = advertisementData[CBAdvertisementDataTxPowerLevelKey] as? Double {
            self.txPower = power
        }
        
        if let txPower = self.txPower {
            print("BleWifiScan distance is ", pow(10, ((txPower - Double(truncating: RSSI))/25)))
        }
        
        let _peripheral = Peripheral(peripheral: peripheral, rssi: RSSI)
        
        if self.peripherals.contains(_peripheral) {
            return
        } else {
            self.peripherals.append(_peripheral)
            self.delegate?.didUpdateDevices()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("BleWifiScan did connect \(peripheral)")
    }
}



