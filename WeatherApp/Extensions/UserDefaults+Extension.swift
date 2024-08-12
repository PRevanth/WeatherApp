//
//  UserDefaults+Extension.swift
//  WeatherApp
//
//  Created by Admin on 8/12/24.
//

import Foundation

extension UserDefaults {
    @UserDefault(key: "searchedLocation")
    static var searchedLocation: String?
}
