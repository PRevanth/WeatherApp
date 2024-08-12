//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Admin on 8/11/24.
//

import Foundation
import CoreLocation

@Observable
class ForecastViewModel: NSObject {
    private struct Constants {
        static let defaultQuery = "New York"
        static let emptyString = ""
    }
    
    let respository: ForecastRepositoryProtocol
    private let locationManager = CLLocationManager()
    
    var isLoading: Bool = false
    private(set) var response: Forecast?
    private var latitude: Double?
    private var longitude: Double?
    
    var isAuthorizedToUseLocation: Bool {
        switch locationManager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            false
        case .authorizedAlways, .authorizedWhenInUse:
            true
        @unknown default:
            false
        }
    }
    
    var hasUserDeniedLocationAcess: Bool {
        locationManager.authorizationStatus == .denied
    }
    
    init(respository: ForecastRepositoryProtocol) {
        self.respository = respository
        super.init()
        self.fetchLocationIfUserHasAccess()
    }
    
    @MainActor
    func fetchForecast(for query: String = Constants.emptyString) async {
        self.isLoading = true
        var location = query
        if location.isEmpty {
            location = UserDefaults.searchedLocation ?? Constants.defaultQuery
        }
        if let weatherResponse = await respository.fetchForecast(withQuery: location) {
            self.response = weatherResponse
            if !query.isEmpty {
                UserDefaults.searchedLocation = query
            }
        }
        self.isLoading = false
    }
    
    @MainActor
    func fetchForecast(for latitude: Double, longitude: Double) async {
        self.isLoading = true
        if let weatherResponse = await respository.fetchForecast(for: latitude, longitude: longitude) {
            self.response = weatherResponse
        }
        self.isLoading = false
    }
    
    func fetchLocationIfUserHasAccess() {
        locationManager.delegate = self
        if isAuthorizedToUseLocation {
            locationManager.startUpdatingLocation()
        } else {
            Task {
                await fetchForecast()
            }
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func fetchLocationBasedOnAccess() async {
        if let latitude,
           let longitude {
            await fetchForecast(for: latitude, longitude: longitude)
        } else {
            await fetchForecast()
        }
    }
}

extension ForecastViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            self.latitude = latitude
            self.longitude = longitude
            locationManager.stopUpdatingLocation()
            Task {
                await fetchLocationBasedOnAccess()
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if isAuthorizedToUseLocation {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        locationManager.stopUpdatingLocation()
        Task {
            await fetchLocationBasedOnAccess()
        }
    }
}
