//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Admin on 8/12/24.
//

import SwiftUI

struct CurrentWeatherView: View {
    var weather: Forecast
    
    var body: some View {
        ZStack {
            Color.primaryBlue
            
            VStack(spacing: 10) {
                Text("Weather in \(weather.name)")
                    .foregroundStyle(.white)
                    .font(.system(size: 18, weight: .bold))
                    .padding(.top, 20)
                Text(weather.sys.country)
                    .foregroundStyle(.white)
                    .font(.system(size: 18, weight: .bold))
                Text(weather.dt.getFormattedDate)
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .regular))
                Text("\(weather.main.temp.formatted())°F")
                    .foregroundStyle(.white)
                    .font(.system(size: 60, weight: .bold))
                
                Text("Min: \(weather.main.tempMin.formatted()) / Max: \(weather.main.tempMax.formatted())")
                    .foregroundStyle(.white)
                    .font(.system(size: 14, weight: .bold))
                
                AsyncImage(
                    url: URL(string: "https://openweathermap.org/img/wn/" + (weather.weather.first?.icon ?? "") + "@2x.png"),
                    content: { image in
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fill)
                    }, placeholder: {
                        Color.primaryBlue
                    })
                .frame(width: 100, height: 100)
                
                Text(weather.weather.first?.main ?? "")
                    .foregroundStyle(.white)
                    .font(.system(size: 14, weight: .bold))
                    .padding(.bottom, 20)
            }
        }
        .cornerRadius(20)
    }
}

extension Double {
    var getFormattedDate: String {
        let date = Date(timeIntervalSince1970: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let outputDate = dateFormatter.string(from: date)
        return outputDate
    }
    
    var getTime: String {
        let date = Date(timeIntervalSince1970: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = Locale.current
        let outputDate = dateFormatter.string(from: date)
        return outputDate
    }
}
