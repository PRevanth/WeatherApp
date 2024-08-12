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
        "http://api.openweathermap.org/data/2.5/weather?q=\(query)&APPID=61cb6a1ac165206c08689d4305d04945&units=imperial"
    }
}

struct ForecastDataLatLongRequest: Requestable {
    var latitude: Double
    var longitude: Double
    
    var url: String {
        "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&APPID=61cb6a1ac165206c08689d4305d04945&units=imperial"
    }
}
