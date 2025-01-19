//
//  APIWeatherDataSource.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import Foundation

//http://api.weatherapi.com/v1/current.json?key=159555725d6b4b439dd211642251601&q=Boston&aqi=no

class APIWeatherDataSource: ApiDataSourceType {
    
    
    
    private let httpClient: HTTPClientType
    private let baseUrl = "https://api.weatherapi.com/v1"
    private let apiKey = "159555725d6b4b439dd211642251601"
  
    
    init(httpClient: HTTPClientType) {
        self.httpClient = httpClient
    }
    
    func getWeatherDTO(for location: String) async -> Result<WeatherDTO, DataError> {
       // let endPoint = "/current.json?key=\(apiKey)&q=\(location)&aqi=no"
        
        let queryParameters: [String: String] = [
            "key" : "159555725d6b4b439dd211642251601",
            "q" : location,
            "aqi": "no"
        ]
        
        let endPoint = EndPoint(path: "/current.json",
                                queryParameters: queryParameters,
                                method: .get)
        
        let result = await httpClient.makeRequest(endpoint: endPoint, baseUrl: baseUrl)
        
        guard case .success(let data) = result else {
            
            return .failure(.dataError)
        }
        
        guard let weatherDTO = try? JSONDecoder().decode(WeatherDTO.self, from: data) else {
            return .failure(.decodingError)
        }
        
        return .success(weatherDTO)
    }
    
    
    func getSuggestionsDTO(for location: String) async -> Result<[CityDTO], DataError> {
        //http://api.weatherapi.com/v1/search.json?key=159555725d6b4b439dd211642251601&q=washington
         
         let queryParameters: [String: String] = [
             "key" : "159555725d6b4b439dd211642251601",
             "q" : location,
         ]
         
         let endPoint = EndPoint(path: "/search.json",
                                 queryParameters: queryParameters,
                                 method: .get)
         
         let result = await httpClient.makeRequest(endpoint: endPoint, baseUrl: baseUrl)
         
         guard case .success(let data) = result else {
             return .failure(.dataError)
         }
         
        guard let suggestionsDTO = try? JSONDecoder().decode([CityDTO].self, from: data) else {
             return .failure(.decodingError)
         }
         
         return .success(suggestionsDTO)
    }
}
