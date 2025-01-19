//
//  WeatherRepository.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import Foundation

protocol WeatherRepositoryType {
    func getWeather(for location: String) async -> Result<WeatherModel, DataError>
    func getLastSearchedWeather() async -> WeatherModel?
    func getSuggestions(for location: String)  async -> [CityModel]
}

class WeatherRepository: WeatherRepositoryType {
    
    
    
    private let apiDataSource: ApiDataSourceType
    private let weatherMapper: WeatherMapperType
    private let cacheDataSource: CacheWeatherType
    
    init(apiDataSource: ApiDataSourceType,
         weatherMapper: WeatherMapperType,
         cacheDataSource: CacheWeatherType) {
        self.apiDataSource = apiDataSource
        self.weatherMapper = weatherMapper
        self.cacheDataSource = cacheDataSource
    }
    
    func getWeather(for location: String) async -> Result<WeatherModel, DataError> {
        let result: Result<WeatherDTO, DataError> = await apiDataSource.getWeatherDTO(for: location)

        guard case .success(let weatherDTO) = result else {
            return .failure(result.failureCase as! DataError)
        }
        
        let mappedWeather = await weatherMapper.map(weatherDTO: weatherDTO)
        
        //saving the weather for the las city in the cache
        await cacheDataSource.saveLastWeatherSearched(for: mappedWeather)
        
       
        return .success(mappedWeather)
        
    }
    
    func getLastSearchedWeather() async -> WeatherModel? {
        let result = await  cacheDataSource.getWeather()
        
        switch result {
            
        case .none:
            return nil
        case .some(let weather):
            return weather
        }
    }
    
    
   
    
    func getSuggestions(for location: String) async -> [CityModel] {
        let result: Result<[CityDTO], DataError> = await apiDataSource.getSuggestionsDTO(for: location)

        guard case .success(let suggestionsDTO) = result else {
          
            print("There is an error: \(String(describing: result.failureCase?.localizedDescription))")
            return []
        }
        
        let mappedWeather = await weatherMapper.map(SuggestionsDTO: suggestionsDTO)
        
        return mappedWeather
    }
}
