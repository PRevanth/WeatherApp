//
//  WeatherSearchViewModel.swift
//  WeatherApp
//
//  Created by Admin on 8/11/24.
//

import Foundation

class WeatherSearchViewModel {
    
    var searchText = "" {
        didSet {
            filterData()
        }
    }
    var shouldReload: (() -> Void)?
    
    let data = [
            (title: "First Item", subtitle: "This is the first item's subtitle"),
            (title: "Second Item", subtitle: "This is the second item's subtitle")
        ]
    
    init() { }
    
    var numberOfRows: Int {
        data.count
    }
    
    func filterData() {
        self.shouldReload?()
    }
    
}
