//
//  ForecastRepository.swift
//  WeatherApp
//
//  Created by Admin on 8/12/24.
//

import Foundation

class ForecastRepository: ForecastRepositoryProtocol {
    let serviceWorker = ServiceWorker()
    func fetchForecast(withQuery query: String) async -> Forecast? {
        await serviceWorker.execute(request: ForecastDataRequest(query: query))
    }
    
    func fetchForecast(for latitude: Double, longitude: Double) async -> Forecast? {
        await serviceWorker.execute(request: ForecastDataLatLongRequest(latitude: latitude, longitude: longitude))
    }
}
