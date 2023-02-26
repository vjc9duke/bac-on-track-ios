//
//  ContentView.swift
//  BAC on Track
//
//  Created by Vincent Chen on 2/19/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTabIndex = 1
    
    //TODO: add glyphs for each tab
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            InfoPage()
                .tabItem() {
                    Image(systemName: "info.circle.fill")
                    Text("Info")
                }.tag(0)
            HomePage()
                .tabItem() {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(1)
            SettingsPage()
                .tabItem() {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
