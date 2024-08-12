//
//  ServiceWorker.swift
//  WeatherApp
//
//  Created by Admin on 8/12/24.
//

import Foundation

protocol ServiceWorkerProtocol {
    func execute<T: Decodable>(request: Requestable) async -> T?
}

public protocol Requestable {
    var url: String { get }
}

class ServiceWorker: ServiceWorkerProtocol {
    func execute<T: Decodable>(request: Requestable) async -> T? {
        guard let url = URL(string: request.url) else {
            // Invalid URL
            return nil
        }
        
        guard let (data, _) = try? await URLSession.shared.data(from: url),
              let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        
        return decodedResponse
    }
}
