//
//  FileReader.swift
//  BAC on Track
//
//  Created by Vincent Chen on 3/26/23.
//

import Foundation

class FileReader {
    
    static func readJSONFile(_ fileName: String) -> [String: Any]? {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName)
        do {
            let jsonData = try Data(contentsOf: fileURL!)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            guard let dict = jsonObject as? [String: Any] else {
                print("Error parsing JSON file: Expected dictionary, but got \(type(of: jsonObject))")
                return nil
            }
            return dict
        } catch {
            print("Error reading or parsing JSON file: \(error.localizedDescription)")
            return nil
        }
    }
}
