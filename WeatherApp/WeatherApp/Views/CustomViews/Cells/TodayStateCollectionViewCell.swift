//
//  TodayStateCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import UIKit

class TodayStateCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Vars
    static let identifier = "TodayStateCollectionViewCell"
    
    private let tempImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "sun.min" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        image.layer.cornerRadius = 10
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    public let tempLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
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
        
        
        contentView.addSubview(tempImageView)
        contentView.addSubview(tempLabel)
        
        
        
    }
    
    private func ConfigureConstraints(){
        NSLayoutConstraint.activate([
            
            tempImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            tempImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            tempImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            tempLabel.topAnchor.constraint(equalTo: tempImageView.bottomAnchor,constant: 5),
            tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            
        ])
    }
    
    //MARK: - Cell Configuration with Models
    
    public func configureCell(model : String, icon: Icons) {
        
        tempLabel.text = model
        tempImageView.image = UIImage(systemName: icon.rawValue , withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
                
    }
}
