//
//  WeatherFactory.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import Foundation


class WeatherFactory {
    
    static let uRLSessionHTTPClient = URLSessionHTTPClient(requestMaker: URLSessionRequestMaker())
    
    static func create() -> WeatherView {
        WeatherView(viewModel: createViewModel() )
    }
    
    private static func createViewModel() -> WeatherViewModel {
        WeatherViewModel(repository: createRepository())
     }
    
    private static func createRepository() -> WeatherRepositoryType {
        WeatherRepository(apiDataSource: createApiDataSource(),
                          weatherMapper:  WeatherMapper(),
                          cacheDataSource: createCacheWeather())
    }
    
    private static func createApiDataSource() -> ApiDataSourceType {
        APIWeatherDataSource(httpClient: uRLSessionHTTPClient)
    }
    
    private static func  createCacheWeather() -> CacheWeatherType {
        CacheWeather()
    }
    
    
}
