//
//  OnboardingViewController.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 18/06/2022.
//

import UIKit
import CoreLocation

class OnboardingViewController: BaseViewController {

    //MARK: - Vars
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    private let welcomeLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .label
        label.textAlignment = .center
        label.text =  "Welcome to the Weather App"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private let shareLocationLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .label
        label.textAlignment = .center
        label.text =  "Please share your current location to get the weather in your area"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    
    private let shareLocationButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share Current Location", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupLayouts()
        configureConstrants()
        
    }
    
    //MARK: - Layouts and Constraints
    private func setupLayouts(){
        
        view.addSubview(welcomeLabel)
        view.addSubview(shareLocationLabel)
        view.addSubview(shareLocationButton)
        
    }
    
    
    private func configureConstrants(){
        NSLayoutConstraint.activate([
        
            shareLocationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shareLocationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shareLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            shareLocationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

    
            welcomeLabel.bottomAnchor.constraint(equalTo: shareLocationLabel.topAnchor,constant: -32),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            shareLocationButton.topAnchor.constraint(equalTo: shareLocationLabel.bottomAnchor,constant: 32),
            shareLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            shareLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            shareLocationButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    private func navigateToHomeViewController() {
        let vc = UINavigationController(rootViewController: HomeViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    //MARK: - ShareLocationButton action

    @objc func didTapShare() {
        setupLocation()
    }
    
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
}


//MARK: - Location Manager Delegate
extension OnboardingViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        ServerConfig.shared.setURLFrom(lat: lat, lon: long)
        navigateToHomeViewController()
    }
}
