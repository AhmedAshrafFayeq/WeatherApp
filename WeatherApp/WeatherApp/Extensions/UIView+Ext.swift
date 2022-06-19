//
//  UIView+Ext.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 19/06/2022.
//

import UIKit

extension UIView {

    func setupView() {
        layer.borderWidth = 0.2
        layer.shadowColor = UIColor.systemBlue.cgColor
        layer.shadowOpacity = 0.8
        alpha = 0.8
    }

}
