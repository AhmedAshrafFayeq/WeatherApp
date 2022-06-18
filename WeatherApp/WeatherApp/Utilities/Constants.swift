//
//  Constants.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 17/06/2022.
//

import Foundation

struct Constants {
    static let APIKEY       = "SXQVZBUJURRHX834V6HFL6Q6D"
    static let APIEncludes  = "&include=current,hours,days"
}

enum Icons: String {
    case rain = "cloud.rain.fill"
    case wind = "wind"
    case humidity = "humidity"
    case pressure = "thermometer.sun"
    
    static func getWeatherIcon(icon: String) -> String {
        switch icon {
        case "clear-day":
            return "sun.max.fill"
            
        case "clear-night":
            return "moon.fill"
            
        case "cloudy":
            return "cloud.fill"
            
        case "partly-cloudy-day":
            return "cloud.sun.fill"
            
        case "partly-cloudy-night":
            return "cloud.moon.fill"
            
        default:
            return "sun.min.fill"
        }
    }
}
