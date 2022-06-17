//
//  ServerConfig.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 17/06/2022.
//

import Foundation

enum BaseUrl: String {
    case DEV  = "https://api.openweathermap.org/data/2.5/"
    case PROD = "https://api.openweathermap.org/data/2.6/"
    case STAG = "https://api.openweathermap.org/data/2.7/"
}

class ServerConfig {
    static let shared: ServerConfig = ServerConfig()
    private init(){}
    
    var baseURL: String?
    
    func setupServerConfig() {
        #if PROD
        self.baseURL = BaseUrl.PROD.rawValue
        #elseif DEV
        self.baseURL = BaseUrl.DEV.rawValue
        #elseif STAG
        self.baseURL = BaseUrl.STAG.rawValue
        #endif
    }
    
     func getURLFrom(lat: Double, lon: Double) -> String {
        return "\(baseURL)oncall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(Constants.APIKEY)&units=imperial"
    }
}
