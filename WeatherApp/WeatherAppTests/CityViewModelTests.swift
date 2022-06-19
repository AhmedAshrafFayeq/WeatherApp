//
//  CityViewModelTests.swift
//  WeatherAppTests
//
//  Created by Ahmed Fayeq on 19/06/2022.
//

import XCTest
@testable import WeatherApp

class CityViewModelTests: XCTestCase {
    
    var viewModel: CityViewModel!

    override func setUpWithError() throws {
        viewModel = CityViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testConfigureWithData() {
        let convertedDate = viewModel.configureWithData(date: "2022-06-19")
        XCTAssertNotEqual("Sun, 06 19, 2022", convertedDate)
        XCTAssertEqual("Sunday, Jun 19, 2022", convertedDate)
    }

}
