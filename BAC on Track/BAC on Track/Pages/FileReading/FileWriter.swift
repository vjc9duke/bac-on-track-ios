//
//  FileWriter.swift
//  BAC on Track
//
//  Created by Vincent Chen on 4/2/23.
//

import Foundation

class FileWriter {
    public static func writeJSONToFile(fileName: String, jsonData: Data) {
        do {
            let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documentsURL.appendingPathComponent(fileName)
            try jsonData.write(to: fileURL, options: .atomic)
            print("File saved to: \(fileURL.absoluteString)")
        } catch {
            print("Error saving file:", error)
        }
    }
}
