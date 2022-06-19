//
//  WeatherAPITest.swift
//  WeatherAppTests
//
//  Created by Ahmed Fayeq on 19/06/2022.
//

import XCTest
@testable import WeatherApp

class WeatherAPITest: XCTestCase {
    
    //create system under test instance of baseAPI
    var sut: BaseApi<WeatherNetworking>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = BaseApi()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testWeatherNetworking() {
        let promise = XCTestExpectation(description: "Fetch Data Completed")
        var responseError : Error?
        var responseResult : WeatherResponse?
        
        guard let bundle =  Bundle.unitTest.path(forResource: "Weather", ofType: "json") else {
            XCTFail("Error : Content not found")
            return
        }
        
        let url = URL(fileURLWithPath: bundle)
        var weatherNetworking = WeatherNetworking.getWeatherData
        weatherNetworking.baseURL = url.absoluteString
        
        sut.fetchData(target: weatherNetworking, responseClass: WeatherResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                responseResult = response
            case .failure(let error):
                responseError = error
            }
            // mark expectation as having been meet
            promise.fulfill()
            self?.wait(for: [promise], timeout: 1)
            XCTAssertNil(responseError)
            XCTAssertNotNil(responseResult)
        }
        if let timeZone = responseResult?.timezone {
            XCTAssertEqual("America/New_York", timeZone)
        }
        if let date = responseResult?.days.first?.hours?.first?.datetime {
            XCTAssertEqual("2022-06-19", date)

        }
        if let dew = responseResult?.days.first?.hours?.first?.dew {
            XCTAssertEqual(40.0, dew)

        }
        if let humidity = responseResult?.days.first?.hours?.first?.humidity {
            XCTAssertEqual(38.98, humidity)

        }
        if let pressure = responseResult?.days.first?.hours?.first?.pressure {
            XCTAssertEqual(1016.1, pressure)
        }
        
    }
    
}
