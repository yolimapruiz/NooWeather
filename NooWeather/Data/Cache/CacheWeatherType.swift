//
//  CacheWeatherType.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import Foundation

protocol CacheWeatherType {
    func getWeather() async -> WeatherModel?
    func saveLastWeatherSearched(for weather: WeatherModel) async
}
