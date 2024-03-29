//
//  TodayWeatherView.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import UIKit

class TodayWeatherView: UIView {
    
    public var currentDay : CurrentDay?
    
    //MARK: - Vars
    private let todayLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.text =  "Today"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
     let tempLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .center
        label.text =  "56.8ºF"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let stateLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        label.text =  "Cloudy"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    
    private let vStackView : UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private let stateImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.tintColor = .white
        image.image = UIImage(systemName: "sun.min" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 60))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let hStackView : UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  =  .fillEqually
        stackView.alignment = UIStackView.Alignment.center
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let collectionView : UICollectionView = {
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 100)
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TodayStateCollectionViewCell.self,
                                forCellWithReuseIdentifier: TodayStateCollectionViewCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()

    //MARK: - Initlizaers
   override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        self.clipsToBounds = true
        setupView()
        setupLayouts()
        configureConstraints()

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Layouts and Constraints
    
    private func setupLayouts(){
        
        addSubview(todayLabel)
        vStackView.addArrangedSubview(tempLabel)
        vStackView.addArrangedSubview(stateLabel)
        hStackView.addArrangedSubview(stateImageView)
        hStackView.addArrangedSubview(vStackView)
        
        addSubview(hStackView)
        addSubview(collectionView)
        
        if let temp = currentDay?.temp {
            tempLabel.text = "\(temp) ºF"
        }
        stateImageView.image = UIImage(systemName:  Icons.getWeatherIcon(icon: currentDay?.icon ?? "sun.min.fill"), withConfiguration: UIImage.SymbolConfiguration(pointSize: 90))
        stateLabel.text = currentDay?.state
        
    }
    
    private func configureConstraints(){
        
        NSLayoutConstraint.activate([
            
            todayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            todayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            hStackView.topAnchor.constraint(equalTo: todayLabel.bottomAnchor,constant: 4),
            hStackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 60),
            hStackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -60),
            hStackView.heightAnchor.constraint(equalToConstant: 80),
            
            collectionView.topAnchor.constraint(equalTo: hStackView.bottomAnchor,constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 40),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -40),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -20)
        ])
    }
}


//MARK: - Extension for CollectionView Functions
extension TodayWeatherView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: TodayStateCollectionViewCell.identifier, for: indexPath) as? TodayStateCollectionViewCell
        else {
            print("can't get category cell")
            return UICollectionViewCell()
        }
        if indexPath.row == 0 {
            cell.configureCell(model: "\(currentDay?.windSpeed ?? 0.0)mi/hr", icon: .wind)
        }else if indexPath.row == 1 {
            cell.configureCell(model: "\(currentDay?.humindty ?? 0.0)%", icon: .humidity )
        }else if indexPath.row == 2 {
            cell.configureCell(model: "\(currentDay?.pressure ?? 0.0)%", icon: .pressure)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    

    // Handle CollectionViewCells allignment (Center)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let totalCellWidth = 90 * 3
        let totalSpacingWidth = 9 * (3 - 1)
        
        let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}
