//
//  Bundle+unitTest.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 19/06/2022.
//

import Foundation

extension Bundle {
    public class var unitTest: Bundle{
        return Bundle(for: WeatherAPITest.self)
    }
}
