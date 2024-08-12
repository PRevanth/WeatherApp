//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Admin on 8/11/24.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {
    func testFetchForecastDefault() async {
        let viewModel = ForecastViewModel(respository: MockForecastRepository())
        await viewModel.fetchForecast()
        XCTAssertEqual(viewModel.isLoading, false, "isLoading should be false")
        XCTAssertNotNil(viewModel.response, "response should not be nil")
        XCTAssertEqual(viewModel.response?.sys.country, "US", "Country is not US")
        XCTAssertEqual(viewModel.response?.name, "New York", "City is not New York")
    }
    
    func testFetchForecastWitCity() async {
        let viewModel = ForecastViewModel(respository: MockForecastRepository())
        await viewModel.fetchForecast(for: "New York")
        XCTAssertEqual(viewModel.isLoading, false, "isLoading should be false")
        XCTAssertNotNil(viewModel.response, "response should not be nil")
        XCTAssertEqual(viewModel.response?.sys.country, "US", "Country is not US")
        XCTAssertEqual(viewModel.response?.name, "New York", "City is not New York")
    }
    
    func testFetchForecastWitCoordinates() async {
        let viewModel = ForecastViewModel(respository: MockForecastRepository())
        await viewModel.fetchForecast(for: 40.7143, longitude: -74.006)
        XCTAssertEqual(viewModel.isLoading, false, "isLoading should be false")
        XCTAssertNotNil(viewModel.response, "response should not be nil")
        XCTAssertEqual(viewModel.response?.sys.country, "US", "Country is not US")
        XCTAssertEqual(viewModel.response?.name, "New York", "City is not New York")
    }
    
    func testFetchForecastError() async {
        let viewModel = ForecastViewModel(respository: MockFailureForecastRepository())
        await viewModel.fetchForecast(for: "New York")
        XCTAssertEqual(viewModel.isLoading, false, "isLoading should be false")
    }
    
    func testUserDefaults() {
        UserDefaults.searchedLocation = nil
        XCTAssertNil(UserDefaults.searchedLocation, "searchedLocation should be nil")
        UserDefaults.searchedLocation = "London"
        XCTAssertEqual(UserDefaults.searchedLocation, "London", "searchedLocation is not London")
        UserDefaults.searchedLocation = nil
        XCTAssertNil(UserDefaults.searchedLocation, "searchedLocation should be nil")
    }
}

class MockForecastRepository: ForecastRepositoryProtocol {
    func fetchForecast(withQuery query: String) async -> Forecast? {
        if let filePath = Bundle(for: Self.self).path(forResource: "Forecast", ofType: "json"),
           let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
           let forecast = try? JSONDecoder().decode(Forecast.self, from: fileContent) {
            return forecast
        } else {
            return nil
        }
    }
    
    func fetchForecast(for latitude: Double, longitude: Double) async -> Forecast? {
        if let filePath = Bundle(for: Self.self).path(forResource: "Forecast", ofType: "json"),
           let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
           let forecast = try? JSONDecoder().decode(Forecast.self, from: fileContent) {
            return forecast
        } else {
            return nil
        }
    }
}

class MockFailureForecastRepository: ForecastRepositoryProtocol {
    func fetchForecast(withQuery query: String) async -> Forecast? {
        nil
    }
    
    func fetchForecast(for latitude: Double, longitude: Double) async -> Forecast? {
        nil
    }
}
