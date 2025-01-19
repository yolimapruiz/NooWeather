//
//  NooWeatherApp.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import SwiftUI

@main
struct NooWeatherApp: App {
    var body: some Scene {
        WindowGroup {
          
            WeatherFactory.create()
        }
    }
}
