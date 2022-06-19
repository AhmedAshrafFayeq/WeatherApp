//
//  DayDetailsHeader.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import UIKit

class DayDetailsHeader: UIView {
    
    //MARK: - Vars
    private let tempLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .center
        label.text =  "56.8ºF"
        label.font = .systemFont(ofSize: 40, weight: .regular)
        return label
    }()
    private let minMaxLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .center
        label.text =  "30º || 69º"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let titleLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        label.text =  "Cairo, Egypt"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let stateImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.tintColor = .systemBackground
        image.image = UIImage(systemName: "sun.min" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 80))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    //MARK: - Initlizaers
    init() {
        super.init(frame: .zero)
    }
    
    init(frame: CGRect, currentDay: CurrentConditions) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        self.clipsToBounds = true
        setupLayouts()
        configureConstraints()
        configureViewData(currentDay: currentDay)
        
        layer.cornerRadius = 25
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK:- Layout and Constraints
    private func setupLayouts(){
        addSubview(tempLabel)
        addSubview(minMaxLabel)
        addSubview(titleLabel)
        addSubview(stateImageView)
        
    }
    
    private func configureConstraints(){
        
        NSLayoutConstraint.activate([
            
            tempLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            tempLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 10),
            
            minMaxLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor,constant: 4),
            minMaxLabel.leadingAnchor.constraint(equalTo: tempLabel.leadingAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: tempLabel.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: minMaxLabel.bottomAnchor,constant: 25),
            
            stateImageView.topAnchor.constraint(equalTo: tempLabel.topAnchor),
            stateImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            stateImageView.widthAnchor.constraint(equalToConstant: 150),
            stateImageView.heightAnchor.constraint(equalToConstant: 150)
            
        ])
    }
    
    func configureViewData(currentDay: CurrentConditions) {
        tempLabel.text  = "\(currentDay.temp)ºF"
        titleLabel.text = getDayDiscription(date:currentDay.datetime)
        if let tempmin = currentDay.tempmin, let tempmax = currentDay.tempmax {
            minMaxLabel.text = "H:\(tempmax)º    L:\(tempmin)º"
        }
        stateImageView.image = UIImage(systemName:  Icons.getWeatherIcon(icon: currentDay.icon ?? "sun.min.fill"), withConfiguration: UIImage.SymbolConfiguration(pointSize: 80))
    }
    
    private func getDayDiscription(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myDate = dateFormatter.date(from: date) ?? Date()

        dateFormatter.dateFormat = "EEEE,\n MM d, yyyy"
        let somedateString = dateFormatter.string(from: myDate)
        
        return somedateString
    }

}
