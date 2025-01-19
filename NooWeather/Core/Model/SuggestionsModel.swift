//
//  SuggestionsModel.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 17/01/25.
//

import Foundation

struct SuggestionsModel:  Codable {
    let suggestions: [CityModel]
}

struct CityModel: Identifiable, Codable {
    let id: Int
    let name: String
}
