//
//  WeatherViewModel.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import Foundation

class WeatherViewModel: ObservableObject {
    
    @Published var weather: WeatherModel? = nil
    @Published var suggestions: [CityModel] = []
    private var debounceTimer: Timer?
    
    private let repository: WeatherRepositoryType
    
    init(repository: WeatherRepositoryType) {
        self.repository = repository
    }
    
    func getWeather(for location: String) {
       
        Task {  @MainActor in
            
            let result = await repository.getWeather(for: location)
            

                switch result {
                    
                case .success(let weather):
                    Task { @MainActor in
                        self.weather = weather
                        
                    }
                    
                case .failure(let error):
                    print("Error fetching weather : \(error.description)")
                }

            
        }
        
       }
       
    func loadInitialWeather() {
        
        Task { @MainActor in
            let result = await repository.getLastSearchedWeather()
            self.weather = result
            
        }
    }
    
    func fetchSuggestions(for query: String) {
        debounceTimer?.invalidate()
        
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] _ in
            guard let self = self else { return }
            guard !query.isEmpty else {
                self.suggestions = []
                return
            }
            
            Task {
                let results = await self.repository.getSuggestions(for: query)
                await MainActor.run {
                    self.suggestions = results
                }
            }
            
        })
    }
    
}
