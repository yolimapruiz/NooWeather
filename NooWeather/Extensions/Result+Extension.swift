//
//  Result+Extension.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 16/01/25.
//

import Foundation

extension Result {
    var failureCase: Error? {
        switch self {
            
        case .success(_):
            return nil
        case .failure(let error):
            return error
        }
    }
}
