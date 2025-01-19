//
//  ApiDataSourceType.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import Foundation

protocol ApiDataSourceType {
    func getWeatherDTO(for location: String) async -> Result<WeatherDTO,DataError>
    func getSuggestionsDTO(for location: String) async -> Result<[CityDTO],DataError>
}
