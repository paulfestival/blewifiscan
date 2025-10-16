//
//  User.swift
//  BleWifiScan
//
//  Created by Pavel Mac on 10/14/25.
//

import Foundation
import CloudKit

class User {
  
  private var id: String?
   
  init() {
  }
  
  public func getUserId(_ completion: @escaping (String?, Error?) -> Void) {
      if let userId = self.id {
          completion(userId, nil)
          return
      }
      
      let container = CKContainer.default()
      container.fetchUserRecordID { (recordId, error) in
          guard let recordId = recordId else {
              print(error ?? "BleWifiScan container error")
              completion(nil, error)
              return
          }
          completion(recordId.recordName, nil)
      }
  }
}
