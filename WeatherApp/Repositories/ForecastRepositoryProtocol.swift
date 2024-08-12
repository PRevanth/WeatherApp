//
//  ForecastRepositoryProtocol.swift
//  WeatherApp
//
//  Created by Admin on 8/12/24.
//

import Foundation

protocol ForecastRepositoryProtocol {
    func fetchForecast(withQuery query: String) async -> Forecast?
    func fetchForecast(for latitude: Double, longitude: Double) async -> Forecast?
}
