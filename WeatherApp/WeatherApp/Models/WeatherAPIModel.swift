//
//  WeatherAPIModel.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 19/06/2022.
//

import Foundation
import RealmSwift

class WeatherAPIModel: Object {
    
    @objc dynamic var queryCost: Int = 0
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    @objc dynamic var resolvedAddress: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var timezone: String = ""

    @objc dynamic var tzoffset: Double = 0.0
    @objc dynamic var days: [CurrentConditionModel] = []
    @objc dynamic var currentConditions: CurrentConditionModel = CurrentConditionModel()

}

class CurrentConditionModel: Object {
    @objc dynamic var datetime: String = ""
    @objc dynamic var datetimeEpoch: Int = 0
    @objc dynamic var temp: Double = 0.0
    @objc dynamic var feelslike: Double = 0.0
    
    @objc dynamic var humidity: Double = 0.0
    @objc dynamic var dew: Double = 0.0
    @objc dynamic var precip: Double = 0.0
    @objc dynamic var precipprob: Double = 0.0

    @objc dynamic var snow: Int = 0
    @objc dynamic var snowdepth: Int = 0

    @objc dynamic var windgust: Double = 0.0
    
    @objc dynamic var windspeed: Double = 0.0

    @objc dynamic var winddir: Double = 0.0

    @objc dynamic var pressure: Double = 0.0

    @objc dynamic var visibility: Double = 0.0
    
    @objc dynamic var cloudcover: Double = 0.0
    @objc dynamic var solarradiation: Double = 0.0
    @objc dynamic var  solarenergy: Double = 0.0
    @objc dynamic var  uvindex: Int = 0
    @objc dynamic var  conditions: String = ""
    @objc dynamic var  icon: String = ""
    @objc dynamic var  sunrise: String = ""
    @objc dynamic var  sunriseEpoch: Int = 0
    @objc dynamic var  sunset: String = ""
    @objc dynamic var  sunsetEpoch: Int = 0
    
    @objc dynamic var  moonphase : Double = 0.0
    @objc dynamic var  tempmax: Double = 0.0
    @objc dynamic var  tempmin: Double = 0.0

    @objc dynamic var  feelslikemax: Double = 0.0


    @objc dynamic var  feelslikemin : Double = 0.0
    @objc dynamic var  precipcover: Double = 0.0


    @objc dynamic var  severerisk: Int = 0
    @objc dynamic var  currentConditionsDescription: String = ""
  
    @objc dynamic var  hours: [CurrentConditionModel] = []
    
}
