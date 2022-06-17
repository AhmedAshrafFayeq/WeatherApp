//
//  Weather.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import Foundation
struct Weather: Codable {
    var dt : Int
    var temp : Double
    var feel_like : Double
    var pressure : Int
    var humidity : Int
    var dew_point : Double
    var clouds : Int
    var wind_speed : Double
    var wind_deg : Int
    var weather: [WeatherDetail]
    
    
    init() {
        dt = 0
        temp = 0.0
        feel_like = 0.0
        pressure = 0
        humidity = 0
        dew_point = 0.0
        clouds  = 0
        wind_speed = 0.0
        wind_deg = 0
        weather = []
    }
}

extension Weather {
    var id: UUID {
        return UUID()
    }
    
}
