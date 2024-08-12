//
//  APIClient.swift
//  WeatherApp
//
//  Created by Admin on 8/11/24.
//

import Foundation

struct ForecastDataRequest: Requestable {
    var query: String
    
    var url: String {
        "http://api.openweathermap.org/data/2.5/weather?q=\(query)&APPID=a09fdee06cbe7c4656f62c32dfe319a8&units=imperial"
    }
}

struct ForecastDataLatLongRequest: Requestable {
    var latitude: Double
    var longitude: Double
    
    var url: String {
        "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&APPID=a09fdee06cbe7c4656f62c32dfe319a8&units=imperial"
    }
}
