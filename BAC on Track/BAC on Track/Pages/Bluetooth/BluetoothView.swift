//
//  BluetoothView.swift
//  BAC on Track
//
//  Created by Vincent Chen on 3/5/23.
//

import Foundation
import SwiftUI
import CoreBluetooth

import SwiftUI
import CoreBluetooth

class BluetoothViewModel: NSObject, ObservableObject {
    private var connectedPeripheral: CBPeripheral?
    private var centralManager: CBCentralManager?
    private var peripherals: [CBPeripheral] = []
    @Published var peripheralNames: [String] = []
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
}

extension BluetoothViewModel: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if((peripheral.name ?? "") == "Arduino" ||
           (peripheral.name ?? "") == "Nano33BLE") {
            self.peripherals.append(peripheral)
            self.peripheralNames.append(peripheral.name!)
            centralManager?.connect(peripheral, options: nil)
        }
        if(peripheral.name != nil) {
            print("Found peripheral: \(peripheral.name!)")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // Save a reference to the connected peripheral
        connectedPeripheral = peripheral
        
        // Discover the services offered by the peripheral
        connectedPeripheral?.discoverServices(nil)
        print("Connected")
        centralManager?.stopScan()
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("Func 1")
        guard error == nil else {
            print("Error discovering services: \(error!.localizedDescription)")
            return
        }
        
        for service in peripheral.services ?? [] {
            // Discover the characteristics of the service
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("Func 2")
        guard error == nil else {
            print("Error discovering characteristics: \(error!.localizedDescription)")
            return
        }
        
        for characteristic in service.characteristics ?? [] {
            // Read the value of the characteristic
            peripheral.readValue(for: characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("Func 3")
        guard error == nil else {
            print("Error reading characteristic value: \(error!.localizedDescription)")
            return
        }
        // Process the data read from the characteristic
        let data = characteristic.value
        print("Data from device: \(data!)")
    }
    
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        print("Func 4")
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Func 5")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Func 6")
    }
    
    func centralManager(_ central: CBCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral) {
        print("Func 7")
    }
    
    func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
        print("Func 8")
    }
}

struct BluetoothView: View {
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    
    var body: some View {
        NavigationView {
            List(bluetoothViewModel.peripheralNames, id: \.self) { peripheral in
                Text(peripheral)
            }
            .navigationTitle("Peripherals")
        }
    }
}
