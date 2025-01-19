//
//  URLSessionRequestMaker.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import Foundation

struct URLSessionRequestMaker {
    
    
    func url(endpoint: EndPoint, baseUrl: String) -> URL? {
           var urlComponents = URLComponents(string: baseUrl + endpoint.path)
           let urlQueryParameters = endpoint.queryParameters.map{ URLQueryItem(name: $0.key, value: "\($0.value)")}
           urlComponents?.queryItems = urlQueryParameters
           
           let url = urlComponents?.url
           
           
           return url
       }
}
