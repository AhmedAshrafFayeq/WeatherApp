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

class HomeViewController: UIViewController {
    
    //MARK: - Vars
    var cityViewModel = CityViewModel()
    var disposeBag = DisposeBag()
    
    private let searchBar : UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Seacrh..."
        
        return search
    }()
    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.register(DayTableViewCell.self, forCellReuseIdentifier: DayTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 16, y: 0, width: view.bounds.width - 32, height: view.bounds.height)
    }
    
    //MARK: - View Configuration
    private func configureView() {
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        configureNavBar()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getData() {
        cityViewModel.getData { [weak self] isSuccess in
            if isSuccess {
                guard let timezone = self?.cityViewModel.weatherResponse?.timezone,
                        let temp = self?.cityViewModel.weatherResponse?.days.first?.temp,
                        let state = self?.cityViewModel.weatherResponse?.days.first?.conditions,
                        let windSpeed = self?.cityViewModel.weatherResponse?.days.first?.windspeed,
                        let humindty = self?.cityViewModel.weatherResponse?.days.first?.humidity,
                      let pressure = self?.cityViewModel.weatherResponse?.days.first?.pressure,
                let date = self?.cityViewModel.configureWithData(date: self?.cityViewModel.weatherResponse?.days[0].datetime ?? "") else {
                          print("Cant create Object correctly ")
                          return
                      }
                
                let currentDay = CurrentDay(countryName: timezone, date: date, state: state, windSpeed: windSpeed, humindty: humindty, pressure: pressure, temp: temp)

                self?.configureHeaderView(currentDay: currentDay)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func configureCurrentDay() {
        
    }
    
    //MARK: - NavBar Configuration
    func configureNavBar()  {
        // set the right buton to the navBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.fill"), style: .done, target: self, action: nil)
        // set search bar in the middle
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    
    //MARK: - Customize Header  for the TableView
    func configureHeaderView(currentDay: CurrentDay)  {
        let  headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: view.bounds.height / 2.5), currentDay: currentDay)
        tableView.tableHeaderView = headerView
        
    }
    
    //MARK: - Rx binding on TableView
    
    func bindTableView() {
       // cityViewModel.weatherResponse.bind(to: tableView.rx.items)
    }
}


//MARK: - Extension for table View Functions
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: DayTableViewCell.identifier, for: indexPath) as? DayTableViewCell else {
            print("can't get category cell")
            return UITableViewCell()
        }


        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    
    // set the height for section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        130
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView = HourSectionView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 150))
        
        return sectionView
        
        
    }
    
}
