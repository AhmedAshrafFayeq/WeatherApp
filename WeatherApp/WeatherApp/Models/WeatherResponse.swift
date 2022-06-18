//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let latitude, longitude: Double
    let address, timezone: String
    let tzoffset: Int
    let days: [CurrentConditions]
    let currentConditions: CurrentConditions
    
}


// MARK: - CurrentConditions
struct CurrentConditions: Codable {
    let datetime: String
    let datetimeEpoch: Int
    let temp, feelslike, humidity, dew: Double
    let precip: Int
    let precipprob: Int?
    let snow, snowdepth: Int
    let windspeed: Double
    let pressure, visibility, cloudcover, solarradiation: Double
    let uvindex: Int
    let conditions: String
    let icon: String
    let hours: [CurrentConditions]?

}
