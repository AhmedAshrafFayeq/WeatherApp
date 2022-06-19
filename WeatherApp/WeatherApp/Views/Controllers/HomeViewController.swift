//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import UIKit
import CoreLocation
import RxSwift
import RxCocoa
import UserNotifications

class HomeViewController: BaseViewController {
    
    //MARK: - Vars
    var cityViewModel   = CityViewModel()
    let disposeBag      = DisposeBag()
    let notificationViewModel = NotificationViewModel()
    
    private let searchBar : UISearchBar = {
        let search = UISearchBar()
        search.placeholder  = "Seacrh..."
        search.barTintColor = .white
        return search
    }()
    
    var activityIndicatorView: ActivityIndicatorView!
    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.register(DayTableViewCell.self, forCellReuseIdentifier: DayTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isHidden = true
        return table
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getData()
        bindTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 16, y: 0, width: view.bounds.width - 32, height: view.bounds.height)
    }
    
    //MARK: - View Configuration
    private func configureView() {
        view.addSubview(tableView)
        activityIndicatorView = ActivityIndicatorView(title: "Processing...", center: self.view.center)
        view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        view.backgroundColor = .systemBackground
        configureNavBar()
        tableView.delegate = self
    }
    
    private func getData() {
        activityIndicatorView.startAnimating()
        cityViewModel.getData { [weak self] isSuccess in
            if isSuccess {
                guard let timezone = self?.cityViewModel.weatherResponse?.timezone,
                      let temp = self?.cityViewModel.weatherResponse?.days.first?.temp,
                      let state = self?.cityViewModel.weatherResponse?.days.first?.conditions,
                      let windSpeed = self?.cityViewModel.weatherResponse?.days.first?.windspeed,
                      let humindty = self?.cityViewModel.weatherResponse?.days.first?.humidity,
                      let pressure = self?.cityViewModel.weatherResponse?.days.first?.pressure,
                      let icon = self?.cityViewModel.weatherResponse?.days.first?.icon,
                      let date = self?.cityViewModel.configureWithData(date: self?.cityViewModel.weatherResponse?.days[0].datetime ?? "") else {
                          print("Cant create Object correctly ")
                          return
                      }
                
                let currentDay = CurrentDay(countryName: timezone, date: date, state: state, icon: icon, windSpeed: windSpeed, humindty: humindty, pressure: pressure, temp: temp)
                
                self?.configureHeaderView(currentDay: currentDay)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.tableView.isHidden = false
                    self?.activityIndicatorView.stopAnimating()
                    self?.requestNotification(title: timezone, body: icon)
                }
            }
        }
    }
    
    func requestNotification(title: String, body: String) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if success {
                print("success ")
                self.notificationViewModel.createNotification(title: title, body: body)
            }
            else {
                print("error ouccerd ")
            }
        }
    }

    //MARK: - NavBar Configuration
    func configureNavBar()  {
        // set the right buton to the navBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.fill"), style: .done, target: self, action: nil)
        // set search bar in the middle
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.tintColor = .white
    }
    
    
    //MARK: - Customize Header  for the TableView
    func configureHeaderView(currentDay: CurrentDay)  {
        let  headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: view.bounds.height / 2.5), currentDay: currentDay)
        tableView.tableHeaderView = headerView
        
    }
    
    //MARK: - Rx binding on TableView
    
    func bindTableView() {
        cityViewModel.currentDayBehaviourSubject.bind(to: tableView.rx.items(cellIdentifier: DayTableViewCell.identifier, cellType: DayTableViewCell.self)){ row, item, cell in
            cell.configureCell(model: item)
        }.disposed(by: disposeBag)
        
        // Did Tap on a specific day
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            let dayDetailsVC = DayPreviewViewController()
            dayDetailsVC.currentDay = self?.cityViewModel.weatherResponse?.days[indexPath.row]
            dayDetailsVC.currentDayHoursBehaviourSubject.on(.next(self?.cityViewModel.weatherResponse?.days[indexPath.row].hours ?? []))
            
            self?.navigationController?.pushViewController(dayDetailsVC, animated: true)
            
        }).disposed(by: disposeBag)
    }
}


//MARK: - Extension for table View Functions
extension HomeViewController : UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    // set the height for section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = HourSectionView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 120), viewModel: self.cityViewModel)
        
        return sectionView
        
    }
    
}
