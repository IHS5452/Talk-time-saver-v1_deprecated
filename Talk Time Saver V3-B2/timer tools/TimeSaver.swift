//
//  TimeSaver.swift
//  Talk Time Saver V3-B2
//
//  Created by user941142 on 2/14/25.
//

import Foundation

class TimeSaver {
    
    struct TimeRecord: Codable {
        var id: String // Unique identifier
        var times: [String]
        var combinedTime: String
        var savedDate: Date
    }
    
    private let recordsKey = "TimeRecords" // Stores all unique keys

    // Generate a random alphanumeric string
    private func generateRandomString(length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in characters.randomElement()! })
    }

    // Save a new time record with a unique key
    func saveTimeRecord(times: [String], combinedTime: String) {
        let uniqueKey = generateRandomString(length: 10) // Unique key for this record
        let record = TimeRecord(id: uniqueKey, times: times, combinedTime: combinedTime, savedDate: Date())

        // Save the record under its unique key
        if let encodedData = try? JSONEncoder().encode(record) {
            UserDefaults.standard.set(encodedData, forKey: uniqueKey)
        }

        // Load the existing keys, add the new key, and save them back
        var savedKeys = loadRecordKeys()
        savedKeys.append(uniqueKey)
        UserDefaults.standard.set(savedKeys, forKey: recordsKey)
    }
    
    // Load all saved time records
    func loadTimeRecords() -> [TimeRecord] {
        let savedKeys = loadRecordKeys()
        var records: [TimeRecord] = []
        
        for key in savedKeys {
            if let savedData = UserDefaults.standard.data(forKey: key),
               let record = try? JSONDecoder().decode(TimeRecord.self, from: savedData) {
                records.append(record)
            }
        }
        return records
    }
    
    // Load all stored record keys
    private func loadRecordKeys() -> [String] {
        return UserDefaults.standard.stringArray(forKey: recordsKey) ?? []
    }

    // Delete a specific time record
    func deleteTimeRecord(id: String) {
        var savedKeys = loadRecordKeys()
        if let index = savedKeys.firstIndex(of: id) {
            savedKeys.remove(at: index)
            UserDefaults.standard.removeObject(forKey: id) // Remove record
            UserDefaults.standard.set(savedKeys, forKey: recordsKey) // Update keys list
        }
    }

    // Clear all saved time records
    func clearAllRecords() {
        let savedKeys = loadRecordKeys()
        for key in savedKeys {
            UserDefaults.standard.removeObject(forKey: key)
        }
        UserDefaults.standard.removeObject(forKey: recordsKey) // Remove the keys list
    }
    
    func loadTimeRecord(by id: String) -> TimeRecord? {
        guard let savedData = UserDefaults.standard.data(forKey: id),
              let record = try? JSONDecoder().decode(TimeRecord.self, from: savedData) else {
            return nil
        }
        return record
    }

}
