//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 17/06/2022.
//

import Foundation
import Alamofire


// protocol oriented
protocol WeatherAPIProtocol {
    func getData(completion: @escaping (Result<WeatherResponse?, AFError>)-> Void)
}

class WeatherAPI: BaseApi<WeatherNetworking>, WeatherAPIProtocol{
    // MARK: - Requests
    
    func getData(completion: @escaping (Result<WeatherResponse?, AFError>)-> Void){
        self.fetchData(target: .getWeatherData, responseClass: WeatherResponse.self) { (result) in
            completion(result)
        }
    }
}
