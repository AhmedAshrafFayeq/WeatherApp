//
//  DayPreviewViewController.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 19/06/2022.
//

import UIKit
import RxCocoa
import RxSwift

class DayPreviewViewController: BaseViewController {
    
    //MARK: - Vars
    var currentDay: CurrentConditions?
    let currentDayHoursBehaviourSubject = BehaviorSubject(value: [CurrentConditions]())
    
    let disposeBag = DisposeBag()
    
    private var subView: DayDetailsHeader = {
        let view = DayDetailsHeader()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .clear
        return view
    }()
    
    private let collectionView : UICollectionView = {
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 150)
        let collectionView = UICollectionView(frame: .zero,  collectionViewLayout: layout)
        collectionView.register(HourCollectionViewCell.self, forCellWithReuseIdentifier: HourCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBlue
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 25
        collectionView.layer.masksToBounds = true
        collectionView.setupView()
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        subView.configureViewData(currentDay: currentDay!)
        view.addSubview(subView)
        view.addSubview(collectionView)
        configureConstraints()
        bindNewElements()
        configureHeaderView()
        collectionView.delegate = self
    }
    
    //MARK: - Customize Header  for the TableView
    func configureHeaderView()  {
        let  headerView = DayDetailsHeader(frame: CGRect(x: 16, y: view.bounds.height / 6, width: view.bounds.width - 32, height: 230), currentDay: currentDay!)
        view.addSubview(headerView)
        headerView.setupView()
        subView = headerView
    }
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            
            subView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height / 6),
            subView.heightAnchor.constraint(equalToConstant: 230),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: subView.bottomAnchor,constant: 48),
            collectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    //MARK: - Rx Binding
    func bindNewElements() {
        
        currentDayHoursBehaviourSubject.bind(to: collectionView.rx.items(cellIdentifier: HourCollectionViewCell.identifier, cellType: HourCollectionViewCell.self)) { row, item, cell in
            
            cell.configureCell(model: item)
        }.disposed(by: disposeBag)
    }
    
}

extension DayPreviewViewController : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 150)
    }
    
}
