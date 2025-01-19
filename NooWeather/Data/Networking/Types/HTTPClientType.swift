//
//  HTTPClientType.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import Foundation

protocol HTTPClientType {
    func makeRequest(endpoint: EndPoint, baseUrl: String) async -> Result<Data, DataError>
}
