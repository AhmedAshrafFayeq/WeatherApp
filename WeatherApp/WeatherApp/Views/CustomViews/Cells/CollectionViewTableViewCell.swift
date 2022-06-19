//
//  CollectionViewTableViewCell.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 19/06/2022.
//

import UIKit
import RxSwift
import RxCocoa

class CollectionViewTableViewCell: UITableViewCell {
    
    //MARK:- Vars
    
    static let identifier = "CollectionViewTableViewCell"
    
    var currentDayBehaviorSubject = BehaviorSubject(value: [CurrentConditions]())
    let disposeBag = DisposeBag()
    
    public let collectionView : UICollectionView = {
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 300)
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HourCollectionViewCell.self, forCellWithReuseIdentifier: HourCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    //MARK:- Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier : String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        contentView.addSubview(collectionView)
        bindNewElements()
        
      
    
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
       
        collectionView.frame = contentView.bounds
 
    }
    
    func bindNewElements(){
        
        self.currentDayBehaviorSubject.bind(to: collectionView.rx.items(cellIdentifier: HourCollectionViewCell.identifier, cellType: HourCollectionViewCell.self)) { row, item, cell in
            cell.tempLabel.text = "\(item.temp)"
            cell.configureCell(model: item)
        }.disposed(by: disposeBag)
        
    }
    
    
    
  //MARK:- Cell Configuration with Model
    func configure(model : CurrentConditions) {
        self.currentDayBehaviorSubject.on(.next(model.hours ?? []))
        
    }
    
    
}

//MARK:- Extension for CollectionView Functions
extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
            guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: HourCollectionViewCell.identifier, for: indexPath) as? HourCollectionViewCell else {
                print("can't get category cell")
                return UICollectionViewCell()
            }
        
            print("get cell correctlly")
            return cell
            
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }
}
