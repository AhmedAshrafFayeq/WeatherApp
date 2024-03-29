//
//  HeaderView.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import UIKit

class HeaderView: UIView {

    //MARK: - Vars
    public let countryLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.text =  "Cairo - Egypt"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()

    public let dateLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.text =  "Sunday, february 7, 2022"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let currentWeatherView : TodayWeatherView = {
        let view = TodayWeatherView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    //MARK: - Initlizaers
    init(frame: CGRect, currentDay: CurrentDay) {
        super.init(frame: frame)
        backgroundColor = .clear
        self.clipsToBounds = true
        setupLayouts()
        configureConstraints()
        
        currentWeatherView.currentDay = currentDay
        countryLabel.text = currentDay.countryName
        dateLabel.text = currentDay.date
        currentWeatherView.tempLabel.text = "\(currentDay.temp)ºF"
        currentWeatherView.stateLabel.text = currentDay.state
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK: - Layout and Constraints
    private func setupLayouts(){
        addSubview(countryLabel)
        addSubview(dateLabel)
        addSubview(currentWeatherView)
    
    }
    
    private func configureConstraints(){
        
        NSLayoutConstraint.activate([
            
            countryLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            countryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            
            dateLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 4),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            currentWeatherView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 48),
            currentWeatherView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 20),
            currentWeatherView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -20),
            currentWeatherView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),

        ])
    }
}
