//
//  ProfileInfo.swift
//  BAC on Track
//
//  Created by Vincent Chen on 4/2/23.
//

import Foundation

class ProfileRetreiver {
    
    private static let profileFile = "profile.json"
    
    public static func getProfileInfo() -> ProfileInfo {
        guard let rawProfile = FileReader.readJSONFile(profileFile) else {
            print("Profile file could not be parsed")
            return ProfileInfo.empty();
        }
        return ProfileInfo(
            name: rawProfile["name"] as? String ?? "",
            weight: rawProfile["weight"] as? String ?? "",
            age: rawProfile["age"] as? String ?? "",
            gender: rawProfile["gender"] as? String ?? ""
        )
    }
    
    public static func writeProfileInfo(_ updatedPI: ProfileInfo) {
        print(updatedPI);
        guard let jsonData = try? JSONSerialization.data(withJSONObject: updatedPI.dictionary, options: .prettyPrinted) else {
            return;
        }
        FileWriter.writeJSONToFile(fileName: profileFile, jsonData:  jsonData)
    }
}

struct ProfileInfo {
    let name: String
    let weight: String
    let age: String
    let gender: String
    
    public static func empty() -> ProfileInfo {
        return ProfileInfo(name: "", weight: "", age: "", gender: "");
    }
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "weight": weight,
            "age": age,
            "gender": gender
        ]
    }
}


