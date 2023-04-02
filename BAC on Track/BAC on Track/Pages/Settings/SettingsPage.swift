//
//  SettingsPage.swift
//  BAC on Track
//
//  Created by Vincent Chen on 2/19/23.
//

import SwiftUI

struct SettingsPage: View {
    @State private var profileInfo = ProfileInfo.empty()
    @State private var togglePlaceholder1 = false
    @State private var togglePlaceholder2 = false
    @State private var togglePlaceholder3 = false
    
    private let genderOptions = ["Male", "Female", "Other"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Profile")
                    .font(.largeTitle)
                    .bold()
                VStack(alignment: .leading, spacing: 10) {
                    Text("Name")
                        .font(.headline)
                    TextField("Enter your name", text: $profileInfo.name)
                        .submitLabel(.done)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("Weight")
                        .font(.headline)
                    TextField("Enter your weight", text: $profileInfo.weight)
                        .submitLabel(.done)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("Age")
                        .font(.headline)
                    TextField("Enter your age", text: $profileInfo.age)
                        .submitLabel(.done)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Gender")
                        .font(.headline)
                    Picker(selection: $profileInfo.gender, label: Text("Gender")) {
                        ForEach(genderOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    Button("Save") {
                        ProfileRetreiver.writeProfileInfo(
                            profileInfo
                        )
                    }
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
        .padding(.top, UIScreen.main.focusedView?.safeAreaInsets.top)
        .onAppear{
            profileInfo = ProfileRetreiver.getProfileInfo()
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
