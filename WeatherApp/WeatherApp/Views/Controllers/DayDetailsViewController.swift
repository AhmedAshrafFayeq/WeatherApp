//
//  DayDetailsViewController.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import UIKit
import RxSwift
import RxCocoa

class DayDetailsViewController: UIViewController {
    
    //MARK: - Vars
    
    var currentDay: CurrentConditions?
    var currentDayBehaviorSubject = BehaviorSubject(value: [CurrentConditions]())
    let disposeBag = DisposeBag()

    private let subView: DayDetailsHeader = {
        let view = DayDetailsHeader()
        //view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.currentDayBehaviorSubject.on(.next(currentDay?.hours ?? []))
        view.addSubview(tableView)
        
        bindTableView()
        configureHeaderView()
        tableView.delegate = self
    }
    
    //MARK: - Layouts / Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 20, y: 0, width: view.frame.width-40, height: view.frame.height)
    }
    
    
    //MARK: - Customize Header  for the TableView
    func configureHeaderView()  {
        let  headerView = DayDetailsHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 170), currentDay: currentDay!)
        tableView.tableHeaderView = headerView
        
    }
    
    func bindTableView() {
        currentDayBehaviorSubject.bind(to: tableView.rx.items(cellIdentifier: CollectionViewTableViewCell.identifier, cellType: CollectionViewTableViewCell.self)){ row, item, cell in
            cell.configure(model: item)
            
        }.disposed(by: disposeBag)
        
        // Did Tap on a specific day
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)
    }
    
    
}


//MARK:- Extension for table View Functions
extension DayDetailsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            print("Can't get the cell correcttly")
            return UITableViewCell()
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100

        }
   
}
