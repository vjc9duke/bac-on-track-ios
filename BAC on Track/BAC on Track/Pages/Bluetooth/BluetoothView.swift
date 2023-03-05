//
//  BluetoothView.swift
//  BAC on Track
//
//  Created by Vincent Chen on 3/5/23.
//

import Foundation
import SwiftUI
import CoreBluetooth

struct BluetoothView: View {
    @StateObject var bleController = BLEController()
    
    var body: some View {
        HStack {
          Image(systemName: "heart.fill")
            .foregroundColor(.white)
            .font(.title2)
            .frame(width: 32)
            
          Button("Connect to sensor") {
              bleController.connectToSensor()
          }
          .buttonStyle(.automatic)
        }.environmentObject(bleController)
    }
}
