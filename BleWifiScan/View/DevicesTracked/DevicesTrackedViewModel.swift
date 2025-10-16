//
//  DevicesTrackedViewModel.swift
//  BleWifiScan
//
//  Created by Pavel Mac on 10/14/25.
//

import Foundation

class DevicesTrackedViewModel {
  
  let deviceManager = DeviceManager.shared
  
  var devicesTrackedCellViewModels: Observable<[DevicesTrackedCellViewModel]> = Observable<[DevicesTrackedCellViewModel]>([])
  
  init() {
      registerModelObservers()
  }
  
  private func registerModelObservers() {
      deviceManager.trackedDevices.addObserver(self, options: [.initial, .new]) { devices, change in
          self.loadDevicesTrackedCellViewModels(devices: devices)
      }
  }
  
  private func loadDevicesTrackedCellViewModels(devices: [Device]) {
    
    var devicesTrackedCellViewModelsArr: [DevicesTrackedCellViewModel] = []
    
    for device in devices {
        devicesTrackedCellViewModelsArr.append(DevicesTrackedCellViewModel(device: device))
    }
    
    self.devicesTrackedCellViewModels.value = devicesTrackedCellViewModelsArr
    
  }
  
  func requestTrackedDevices() {
      self.deviceManager.getTrackedDevices()
  }
  
  func delete(device: DevicesTrackedCellViewModel) {
      self.deviceManager.delete(device: device.device)
  }
}
