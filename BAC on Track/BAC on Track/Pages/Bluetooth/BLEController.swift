//
//  BLEController.swift
//  BAC on Track
//
//  Created by Vincent Chen on 3/5/23.
//

import Foundation
import CoreBluetooth

class BLEController: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    @Published var isSwitchedOn = false
    @Published var bac: Float = 0
    
    var myCentral: CBCentralManager!
    let bacTrackerUUID = CBUUID(string: "2A56") //TODO: find UUID for sensor
    
    override init() {
        super.init()
        myCentral = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        isSwitchedOn = (central.state == .poweredOn)
    }
    
    func connectToSensor() {
        myCentral.scanForPeripherals(withServices: [bacTrackerUUID], options: nil)
    }
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        peripheral.delegate = self
        central.connect(peripheral, options: nil)
    }
}
