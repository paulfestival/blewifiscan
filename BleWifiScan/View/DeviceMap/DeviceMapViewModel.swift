//
//  DeviceMapViewModel.swift
//  BleWifiScan
//
//  Created by Pavel Mac on 10/15/25.
//

import Foundation

class DeviceMapViewModel {
  
  let deviceManager = DeviceManager.shared
  let locationManager = LocationManager()
  var currentLocation: Observable<Location> = Observable<Location>(Location(latitude: 0.0, longitude: 0.0))
  var devices: Observable<[Device]> = Observable<[Device]>([])
  
  init() {
      registerObservers()
  }
  
  private func registerObservers() {
      deviceManager.trackedDevices.addObserver(self, options: [.new]) { devices, change in
          self.devices.value = []
          self.devices.value =  devices
      }
  }
  
  func getCurrentLocation() {
      locationManager.getLocation { (location) in
          guard let location = location else { return }
          self.currentLocation.value = location
      }
  }
}
