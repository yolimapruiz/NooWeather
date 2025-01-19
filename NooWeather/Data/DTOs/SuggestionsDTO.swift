//
//  SuggestionsDTO.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 17/01/25.
//

import Foundation


struct CityDTO: Codable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case region
        case country
        case lat
        case lon
        case url
    }
}
