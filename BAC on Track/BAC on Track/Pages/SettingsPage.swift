//
//  SettingsPage.swift
//  BAC on Track
//
//  Created by Vincent Chen on 2/19/23.
//

import SwiftUI

struct SettingsPage: View {
    @State private var name = ""
    @State private var weight = ""
    @State private var age = ""
    @State private var gender = ""
    @State private var togglePlaceholder1 = false
    @State private var togglePlaceholder2 = false
    @State private var togglePlaceholder3 = false
    
    var body: some View {
        ScrollView {
        VStack(alignment: .leading, spacing: 20) {
            Text("Profile")
                .font(.largeTitle)
                .bold()
            VStack(alignment: .leading, spacing: 10) {
                Text("Name")
                    .font(.headline)
                TextField("Enter your name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Weight")
                    .font(.headline)
                TextField("Enter your weight", text: $weight)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Age")
                    .font(.headline)
                TextField("Enter your age", text: $age)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Gender")
                    .font(.headline)
                TextField("Enter your gender", text: $gender)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Divider()
            
            Text("Settings")
                .font(.largeTitle)
                .bold()
            
            Toggle("Placeholder 1", isOn: $togglePlaceholder1)
                            
            Toggle("Placeholder 2", isOn: $togglePlaceholder2)
            
            Toggle("Placeholder 3", isOn: $togglePlaceholder3)
             
            Spacer()
        }
        .padding()
    }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
