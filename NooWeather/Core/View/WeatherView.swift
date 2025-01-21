//
//  WeatherView.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
                HStack {
                    TextField("Search Location", text: $searchText, onEditingChanged: { isEditing in
                        if isEditing {
                            isSearching = true
                        }
                    })
                    .padding(10)
                    .frame(width: 327, height: 46)
                    .background(Color.backgroundLightGray)
                    .foregroundStyle(Color.mediumGrayBackground)
                    .cornerRadius(16)
                    .overlay(
                        HStack {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                    )
                    .onSubmit {
                        viewModel.getWeather(for: searchText)
                        searchText = ""
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
                
                Spacer()
                
                
                switch viewModel.weather {
                case .some(let weather):
                    
                    if isSearching {
                        searchingView()
                    } else {
                        weatherDetailsView(weather: weather)
                    }
                case .none:
                    
                    if isSearching {
                        searchingView()
                        
                    } else {
                        emptyStateView
                            .padding(.top, 240)
                    }
                }
                
                
            }
            .padding(.bottom, 271)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .onAppear {
                viewModel.loadInitialWeather()
            }
            .onChange(of: searchText) { NV, OV in
                viewModel.fetchSuggestions(for: OV)
            }
        }
    }
    
    @ViewBuilder
    private func searchingView() -> some View {
        SearchingView(
            viewModel: viewModel,
            onCitySelected: { city in
                isSearching = false
                searchText = ""
                viewModel.getWeather(for: city.name)
            }
        )
    }
    
    // MARK: - Empty State View
    @ViewBuilder
    private var emptyStateView: some View {
        VStack {
           
            Text("No City Selected")
                .font(.custom("Poppins-SemiBold", size: 30))
                .foregroundStyle(Color.customDarkGray)
            
            Text("Please Search For A City")
                .font(.custom("Poppins-SemiBold", size: 15))
                .foregroundStyle(Color.customDarkGray)
            
        }
        
    }
    
    // MARK: - Weather Details View
    @ViewBuilder
    private func weatherDetailsView(weather: WeatherModel) -> some View {
        VStack(spacing: 16) {
            weatherLocationAndTemperatureView(weather: weather)
            additionalWeatherDetailsView(weather: weather)
        }
        .padding()
    }
    
    // MARK: - Weather Location and Temperature
    @ViewBuilder
    private func weatherLocationAndTemperatureView(weather: WeatherModel) -> some View {
        VStack(spacing: 24) {
            AsyncImage(url: URL(string: weather.iconImage)) { image in
                image
                    .scaledToFit()
                    .frame(width: 123)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 123, height: 123)
            }
            
            HStack {
                Text(weather.name)
                    .font(.custom("Poppins-SemiBold", size: 30))
                    .foregroundStyle(Color.customDarkGray)
                Image(systemName: "location.fill")
                    .foregroundColor(Color.customDarkGray)
            }
            HStack {
                Text("\(Int(weather.temp))")
                   .font(.custom("Poppins-Medium", size: 68))
                   // .font(.headline)
                    .foregroundStyle(Color.customDarkGray)
                    
                VStack {
                    Text("°")
                        .font(.custom("Poppins-Medium", size: 40))
                        .foregroundStyle(Color.customDarkGray)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                
            }
            .frame(width: 105)
        }
    }
    
    // MARK: - Additional Weather Details
    @ViewBuilder
    private func additionalWeatherDetailsView(weather: WeatherModel) -> some View {
        HStack {
            VStack(spacing: 2) {
                Text("Humidity")
                    .font(.custom("Poppins-Medium", size: 12))
                    .foregroundStyle(Color.mediumGrayBackground)
                Text("\(weather.humidity)%")
                    .font(.custom("Poppins-Medium", size: 15))
                    .foregroundStyle(Color.mediumTitleGray)
            }
            
            Spacer()
            
            VStack(spacing: 2) {
                Text("UV")
                    .font(.custom("Poppins-Medium", size: 12))
                    .foregroundStyle(Color.mediumGrayBackground)
                Text("\(weather.uVIndex)")
                    .font(.custom("Poppins-Medium", size: 15))
                    .foregroundStyle(Color.mediumTitleGray)
            }
            
            Spacer()
            
            VStack(spacing: 2) {
                Text("Feels Like")
                    .font(.custom("Poppins-Medium", size: 12))
                    .foregroundStyle(Color.mediumGrayBackground)
                Text("\(Int(weather.feelsLike))°")
                    .font(.custom("Poppins-Medium", size: 15))
                    .foregroundStyle(Color.mediumTitleGray)
            }
        }
        .padding()
        .frame(width: 274, height: 75)
        .background(Color.backgroundLightGray)
        .cornerRadius(16)
    }
}



#Preview {
    WeatherView(viewModel: weatherViewModelMock)
}
