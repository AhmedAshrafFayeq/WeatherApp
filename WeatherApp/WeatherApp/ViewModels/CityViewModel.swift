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
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        return formatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    var date : String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weatherResponse!.tzoffset)))
    }
    
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
    
    func dateFormat(offset : Int) -> String{
         return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(offset)))
    }
    
    func configureWithData(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let myDate = dateFormatter.date(from: date) ?? Date()

        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let somedateString = dateFormatter.string(from: myDate)
        
        return somedateString
    }
    
}
