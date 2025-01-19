//
//  WeatherModel.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import UIKit

struct WeatherModel: Identifiable, Codable {
    let id: UUID
    let name: String
    let temp: Double
    var iconImage: String
   // - Weather condition (with corresponding icon from the API).
   
    let humidity: Int
    let uVIndex: Double
    let feelsLike: Double
}
