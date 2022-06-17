//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Vars
    private let searchBar : UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Seacrh..."
        
        return search
    }()
    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        //table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - View Configuration
    private func configureView() {
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        configureNavBar()
        configureHeaderView()
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
    func configureHeaderView()  {
        let  headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2.5))
        tableView.tableHeaderView = headerView
        
    }
}
