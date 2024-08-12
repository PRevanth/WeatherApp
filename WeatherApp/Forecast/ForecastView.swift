//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Admin on 8/12/24.
//

import SwiftUI

struct ForecastView: View {
    @State var text: String = ""
    @FocusState private var isSearchFocused: Bool
    
    var viewModel: ForecastViewModel
    
    var body: some View {
        ZStack {
            VStack {
                searchBarView
                if viewModel.response == nil {
                    Spacer()
                } else {
                    weatherContainerView
                    Spacer()
                }
            }
            
            if viewModel.isLoading {
                ProgressView(isLoading: viewModel.isLoading)
            }
        }
        .disabled(viewModel.isLoading)
    }
    
    @ViewBuilder
    var searchBarView: some View {
        ZStack {
            Color.primaryBlue
            HStack {
                TextField("Enter new location", text: $text)
                    .padding(7)
                    .padding(.horizontal, 10)
                    .background(Color.secondaryBlue)
                    .cornerRadius(8)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                    .focused($isSearchFocused)
                    .submitLabel(.search)
                    .onSubmit {
                        Task {
                            await viewModel.fetchForecast(for: text)
                        }
                    }
                Button {
                    isSearchFocused = false
                    Task {
                        await viewModel.fetchForecast(for: text)
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white)
                }
                .padding(.trailing, 10)
            }
        }
        .clipShape(
            .rect(
                topLeadingRadius: 0,
                bottomLeadingRadius: 20,
                bottomTrailingRadius: 20,
                topTrailingRadius: 0
            )
        )
        .edgesIgnoringSafeArea(.all)
        .frame(height: 100)
    }
    
    @ViewBuilder
    var weatherContainerView: some View {
        ScrollView {
            CurrentWeatherView(weather: viewModel.response!)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
                .padding(.top, 20)
        }
        .scrollDisabled(true)
    }
}

#Preview {
    ForecastView(viewModel: ForecastViewModel(respository: ForecastRepository()))
}

