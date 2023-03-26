//
//  HistoryParser.swift
//  BAC on Track
//
//  Created by Vincent Chen on 3/26/23.
//

import Foundation

class HistoryParser {
    
    public static func getHistory() -> [History] {
        return [];
    }
}

struct History {
    let day: Date
    let measurements: [BACMeasurement]
}

struct BACMeasurement {
    let time: Date
    let bac: Double
}
