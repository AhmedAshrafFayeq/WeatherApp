//
//  DataFormatter+Ext.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import Foundation

extension DateFormatter {
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        return formatter
    }()
    
    static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    static func formatLongDate(timeOffset: Double) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeOffset)))
    }
    
    static let allDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter
    }()
    
    static let currentDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MMM-dd"
        return formatter
    }()
    
}

extension Date {
    
    func longDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            return dateFormatter.string(from: self)
        }
}
