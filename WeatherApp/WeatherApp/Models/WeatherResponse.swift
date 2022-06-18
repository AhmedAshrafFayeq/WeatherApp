//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let queryCost: Int
    let latitude, longitude: Double
    let resolvedAddress, address, timezone: String
    let tzoffset: Double
    let days: [CurrentConditions]
    let currentConditions: CurrentConditions
}

// MARK: - CurrentConditions
struct CurrentConditions: Codable {
    let datetime: String
    let datetimeEpoch: Int
    let temp, feelslike, humidity, dew: Double
    let precip: Double
    let precipprob: Double?
    let snow, snowdepth: Int
    let windgust: Double?
    let windspeed, winddir, pressure, visibility: Double
    let cloudcover, solarradiation: Double
    let solarenergy: Double?
    let uvindex: Int
    let conditions: String?
    let icon: String?
    let sunrise: String?
    let sunriseEpoch: Int?
    let sunset: String?
    let sunsetEpoch: Int?
    let moonphase, tempmax, tempmin, feelslikemax: Double?
    let feelslikemin, precipcover: Double?
    let severerisk: Int?
    let currentConditionsDescription: String?
    let hours: [CurrentConditions]?
}
