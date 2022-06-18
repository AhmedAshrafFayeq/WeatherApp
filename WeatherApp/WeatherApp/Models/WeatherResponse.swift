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
    let tzoffset: Int
    let days: [CurrentConditions]
    let stations: [String: Station]
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
    let preciptype: [Icon]?
    let windgust, windspeed, winddir: Double?
    let pressure, visibility, cloudcover, solarradiation: Double
    let solarenergy: Double?
    let uvindex: Int
    let conditions: Conditions
    let icon: Icon
    let stations: [ID]?
    let sunrise: String?
    let sunriseEpoch: Int?
    let sunset: String?
    let sunsetEpoch: Int?
    let moonphase, tempmax, tempmin, feelslikemax: Double?
    let feelslikemin, precipcover: Double?
    let severerisk: Int?
    let currentConditionsDescription: String?
    let source: Source?
    let hours: [CurrentConditions]?

    enum CodingKeys: String, CodingKey {
        case datetime, datetimeEpoch, temp, feelslike, humidity, dew, precip, precipprob, snow, snowdepth, preciptype, windgust, windspeed, winddir, pressure, visibility, cloudcover, solarradiation, solarenergy, uvindex, conditions, icon, stations, sunrise, sunriseEpoch, sunset, sunsetEpoch, moonphase, tempmax, tempmin, feelslikemax, feelslikemin, precipcover, severerisk
        case currentConditionsDescription = "description"
        case source, hours
    }
}

enum Conditions: String, Codable {
    case clear = "Clear"
    case overcast = "Overcast"
    case partiallyCloudy = "Partially cloudy"
    case rainOvercast = "Rain, Overcast"
    case rainPartiallyCloudy = "Rain, Partially cloudy"
}

enum Icon: String, Codable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case rain = "rain"
}

enum Source: String, Codable {
    case comb = "comb"
    case fcst = "fcst"
    case obs = "obs"
}

enum ID: String, Codable {
    case d5621 = "D5621"
    case eglc = "EGLC"
    case egll = "EGLL"
    case egwu = "EGWU"
}

// MARK: - Station
struct Station: Codable {
    let distance: Int
    let latitude, longitude: Double
    let useCount: Int
    let id: ID
    let name: String
    let quality, contribution: Int
}

