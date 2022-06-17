//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import Foundation

struct DailyWeather: Codable{
    var dt: Int
    var temp: Temprature
    var weather: [WeatherDetail]
    
    init() {
        dt = 0
        temp = Temprature(min: 0.0, max: 0.0)
        weather = [WeatherDetail(main: "", description: "", icon: "")]
    }
}

