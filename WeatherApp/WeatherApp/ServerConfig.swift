//
//  ServerConfig.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 17/06/2022.
//

import Foundation

enum BaseUrl: String {
    case PROD = "sss"
    case DEV  = "www"
    case STAG = "fff"
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
}
