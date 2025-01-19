//
//  weatherMapper.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import Foundation

protocol WeatherMapperType {
    func map(weatherDTO: WeatherDTO) async -> WeatherModel
    func map(SuggestionsDTO: [CityDTO]) async -> [CityModel]
}

struct WeatherMapper: WeatherMapperType {
    func map(weatherDTO: WeatherDTO) async -> WeatherModel {
        let mappedWeather = WeatherModel(id: UUID(),
                                         name: weatherDTO.location.name,
                                         temp: weatherDTO.current.tempF,
                                         iconImage: "https:\(weatherDTO.current.condition.icon)",
                                         humidity: weatherDTO.current.humidity,
                                         uVIndex: weatherDTO.current.uv,
                                         feelsLike:  weatherDTO.current.feelslikeF)
        
        return mappedWeather
    }
    
    func map(SuggestionsDTO: [CityDTO]) async -> [CityModel] {
        let mappedSuggestions: [CityModel] = SuggestionsDTO.map{
            
            CityModel(id: $0.id,
                      name: $0.name)
           
        }
        
        return mappedSuggestions
    }
    
    
}
