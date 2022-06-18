//
//  HourSectionView.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import UIKit

class HourSectionView: UIView {
    
    //MARK: - Vars
    private let collectionView : UICollectionView = {
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 300)
        
        let collectionView = UICollectionView(frame: .zero,  collectionViewLayout: layout)
        collectionView.register(HourCollectionViewCell.self, forCellWithReuseIdentifier: HourCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    
    //MARK: - Initlizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView ()
        
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK: - Layout / Constraints
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
    
    private func configureView() {
        backgroundColor     = .systemBlue
        layer.shadowColor   = UIColor.systemBlue.cgColor
        layer.shadowOffset  = .zero
        layer.cornerRadius  = 15
        layer.shadowRadius  = 10
        layer.shadowOpacity = 0.3
        
    }
    
}

//MARK: - Extension for CollectionView Functions
extension HourSectionView :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: HourCollectionViewCell.identifier, for: indexPath) as? HourCollectionViewCell
        else {
            print("can't get category cell")
            return UICollectionViewCell()
        }
        //  cell.configureCell(model: self.products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 130)
    }
}
