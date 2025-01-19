//
//  Mocks.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import Foundation

let URLSessionHTTPClientMock = URLSessionHTTPClient(requestMaker: URLSessionRequestMaker())

let repositoryMock = WeatherRepository(apiDataSource: APIWeatherDataSource(httpClient: URLSessionHTTPClientMock),
                                       weatherMapper: WeatherMapper(),
                                       cacheDataSource:  CacheWeather())

let weatherViewModelMock = WeatherViewModel(repository: repositoryMock)
