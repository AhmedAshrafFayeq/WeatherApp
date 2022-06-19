//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class CityViewModel {
    
    //MARK: - Vars
    var weatherAPI = WeatherAPI()
    var weatherResponse: WeatherResponse?
    let currentDayHoursBehaviourSubject = BehaviorSubject(value: [CurrentConditions]())
    let currentDayBehaviourSubject      = BehaviorSubject(value: [CurrentConditions]())
    
//    let realm = try! Realm() -->> TODO
    
    //MARK: - Methods
    func getData(completion: @escaping (Bool)->(Void)) {
        weatherAPI.getData(completion: { [weak self] (result) in
            guard let self = self else{return}
            
            switch result{
            case .success(let response):
                guard let response = response else{return}
                self.weatherResponse = response
                self.currentDayHoursBehaviourSubject.on(.next(response.days.first?.hours ?? []))
                self.currentDayBehaviourSubject.on(.next(response.days))
                completion(true)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        })
    }

    func configureWithData(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let myDate = dateFormatter.date(from: date) ?? Date()

        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let somedateString = dateFormatter.string(from: myDate)
        
        return somedateString
    }
    
    
//    func saveDataInRealmDatabase(response: WeatherResponse) {
//        let weatherRealmModel = WeatherAPIModel()
//        weatherRealmModel.timezone = response.timezone
//        
//        try! realm.write({
//            realm.add(weatherRealmModel)
//        })
//    }

    
}
