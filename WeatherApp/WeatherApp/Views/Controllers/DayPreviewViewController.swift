//
//  DayPreviewViewController.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 19/06/2022.
//

import UIKit
import RxCocoa
import RxSwift

class DayPreviewViewController: UIViewController {
    
    //MARK: - Vars
    var currentDay: CurrentConditions?
    let currentDayHoursBehaviourSubject = BehaviorSubject(value: [CurrentConditions]())
    
    let disposeBag = DisposeBag()
    
    private var subView: DayDetailsHeader = {
        let view = DayDetailsHeader()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        return scrollView
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
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        subView.configureViewData(currentDay: currentDay!)
        view.addSubview(scrollView)
        scrollView.addSubview(subView)
        scrollView.addSubview(collectionView)
        configureConstraints()
        bindNewElements()
        configureHeaderView()
        collectionView.delegate = self
    }
    
    //MARK: - Customize Header  for the TableView
    func configureHeaderView()  {
        let  headerView = DayDetailsHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 230), currentDay: currentDay!)
        scrollView.addSubview(headerView)
        subView = headerView
    }
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            subView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subView.heightAnchor.constraint(equalToConstant: 230),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: subView.bottomAnchor,constant: 32),
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
