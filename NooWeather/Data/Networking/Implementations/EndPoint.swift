//
//  EndPoint.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import Foundation


struct EndPoint {
    
    let path: String
    let queryParameters: [String: Any]
    let method: HTTPMethod
}
