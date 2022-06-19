//
//  WeatherNetworking.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 17/06/2022.
//

import Foundation
import Alamofire

enum WeatherNetworking {
    case getWeatherData
}

extension WeatherNetworking: TargetType{
    var baseURL: String {
        get {
            return ServerConfig.shared.url ?? ""
        }
        set {}
    }

    var path: String {
        switch self {
        case .getWeatherData:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getWeatherData:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getWeatherData:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}
