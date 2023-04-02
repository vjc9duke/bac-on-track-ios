//
//  HistoryParser.swift
//  BAC on Track
//
//  Created by Vincent Chen on 3/26/23.
//

import Foundation

class HistoryParser {
    
    private static let historyKey = "history"
    private static let dateKey = "date"
    private static let measurementsKey = "measurements"
    private static let timeKey = "time"
    private static let bacKey = "bac"
    
    private static let historyFile = "history.json"
    private static let dayFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    private static let timeFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    
    public static func getHistory() -> [History] {
        guard let history = FileReader.readJSONFile(historyFile) else {
            print("History file could not be parsed")
            return [];
        }
        guard let rawHistoryList = history[historyKey] as? [[String: Any]] else {
            print("History list missing")
            return [];
        }
        return rawHistoryList.map { rh in
            convertAnyToHistory(rh)
        }
    }
    
    private static func convertAnyToHistory(_ obj: [String: Any]) -> History {
        let date = dayFormatter.date(from: obj[dateKey] as? String ?? "1970-01-01")!;
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString = dateFormatter.string(from: date)
        
        return History(
            id: dateString,
            day: date,
            measurements: (obj[measurementsKey] as? [[String: Any]] ?? []).map { o in
                convertAnyToMeasurement(o)
            }
        );
    }
    
    private static func convertAnyToMeasurement(_ obj: [String: Any]) -> BACMeasurement {
        return BACMeasurement(
            id: obj[timeKey] as? String ?? "00:00",
            time: timeFormatter.date(from: obj[timeKey] as? String ?? "00:00")!,
            bac: obj[bacKey] as? Double ?? 0.0
        );
    }
}

struct History : Identifiable, Equatable {
    let id: String
    let day: Date
    let measurements: [BACMeasurement]
    
    static func == (lhs: History, rhs: History) -> Bool {
        return lhs.id == rhs.id;
    }
}

struct BACMeasurement : Identifiable {
    let id: String;
    let time: Date
    let bac: Double
}
