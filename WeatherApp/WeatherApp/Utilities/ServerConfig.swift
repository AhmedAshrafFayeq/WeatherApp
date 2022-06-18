//
//  ServerConfig.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 17/06/2022.
//

import Foundation

enum BaseUrl: String {
    case DEV  = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/"
    case PROD = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/  "
    case STAG = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/ "
}

class ServerConfig {
    static let shared: ServerConfig = ServerConfig()
    private init(){}
    
    var baseURL: String?
    var url: String?
    
    func setupServerConfig() {
        #if PROD
        self.baseURL = BaseUrl.PROD.rawValue
        #elseif DEV
        self.baseURL = BaseUrl.DEV.rawValue
        #elseif STAG
        self.baseURL = BaseUrl.STAG.rawValue
        #endif
    }
    
     func setURLFrom(lat: Double, lon: Double){
         guard let baseURL = baseURL else {
             return
         }
         url = "\(baseURL)\(lat),\(lon)?key=\(Constants.APIKEY)\(Constants.APIEncludes)"
    }
}
