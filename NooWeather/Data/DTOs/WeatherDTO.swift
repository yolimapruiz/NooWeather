//
//  WeatherDTO.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import Foundation

struct WeatherDTO: Codable {
    let location: Location
    let current: CurrentWeather
}

struct Location: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name

    }
}

struct CurrentWeather: Codable {
    let tempF: Double
   let condition: WeatherCondition
    let humidity: Int
   let feelslikeF: Double
    let uv: Double

    enum CodingKeys: String, CodingKey {

        case tempF = "temp_f"
        case condition
        case humidity
        case feelslikeF = "feelslike_f"
        case uv

    }
}

struct WeatherCondition: Codable {
    let text: String
    let icon: String
    let code: Int
}
