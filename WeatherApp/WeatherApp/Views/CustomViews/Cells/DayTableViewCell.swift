//
//  DayTableViewCell.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import UIKit

class DayTableViewCell: UITableViewCell {
    
    //MARK: - Vars
    static let identifier = "DayTableViewCell"
    
    public let dayLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.text = "10 AM"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    public let tempLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.text = "40%"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let tempImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "sun.min" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        image.backgroundColor = .systemBackground
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    
    
    private let hStackView : UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier : String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayouts()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK: - Layouts and Constraints
    private func setupLayouts(){
        
        hStackView.addArrangedSubview(dayLabel)
        hStackView.addArrangedSubview(tempLabel)
        hStackView.addArrangedSubview(tempImageView)
        
        contentView.addSubview(hStackView)
    }
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            
            hStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            hStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            hStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
        ])
        
        
    }
    
    //MARK: - Cell Configuration with Models
    public func configureCell() {
        
        
        
    }
    
    
    
}
