//
//  WeatherCellView.swift
//  WeatherApp
//
//  Created by Admin on 8/11/24.
//

import SwiftUI

struct WeatherCellView: View {
    
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
    
    
}
