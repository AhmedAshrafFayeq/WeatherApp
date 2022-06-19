//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 19/06/2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    let gradiantLayer : CAGradientLayer = {
        let gradiant = CAGradientLayer()
        gradiant.colors = [
            
            UIColor(red: 48 / 255.0, green: 231 / 255.0, blue: 273 / 255.0, alpha: 1.0).cgColor,
            UIColor(red: 0 / 255.0, green: 266 / 255.0, blue: 325 / 255.0, alpha: 1.0).cgColor
            
        ]
        
        return gradiant
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradiantLayer.frame = view.bounds
        view.layer.addSublayer(gradiantLayer)
    }
    
    
}
