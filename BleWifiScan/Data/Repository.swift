//
//  Repository.swift
//  BleWifiScan
//
//  Created by Pavel Mac on 10/16/25.
//

import Foundation

protocol Repository {
    
    associatedtype T
    
    func getAll() -> [T]
    func get( identifier:Int ) -> T?
    func create( a:T ) -> Bool
    func update( a:T ) -> Bool
    func delete( a:T ) -> Bool
}
