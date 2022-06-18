//
//  HourCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Vars
    static let identifier = "HourCollectionViewCell"
    
    public let timeLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let tempImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "sun.min" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        image.tintColor = .white
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    public let tempLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let vStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    //MARK: - Initilizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        setupLayouts()
        ConfigureConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Layouts / Constraints
    private func setupLayouts(){
        
        vStackView.addArrangedSubview(timeLabel)
        vStackView.addArrangedSubview(tempImageView)
        vStackView.addArrangedSubview(tempLabel)
        contentView.addSubview(vStackView)
        
    }
    
    private func ConfigureConstraints(){
        NSLayoutConstraint.activate([
            
            vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
        ])
    }
    
    //MARK: - Cell Configuration with Models
    public func configureCell(model: CurrentConditions) {
        timeLabel.text = getHourDiscription(date:model.datetime)
        tempLabel.text = "\(model.temp)"
        tempImageView.image = UIImage(systemName:  Icons.getWeatherIcon(icon: model.icon ?? "cloud.sun.bolt.fill"), withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
    }
    
    private func getHourDiscription(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        let myDate = dateFormatter.date(from: date) ?? Date()

        dateFormatter.dateFormat = "h a"
        let somedateString = dateFormatter.string(from: myDate)
        
        return somedateString
    }
    
}
