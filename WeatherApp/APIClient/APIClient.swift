//
//  APIClient.swift
//  WeatherApp
//
//  Created by Admin on 8/11/24.
//

//import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidURL
    case requestFailed
    case parsingFailed
}

enum BaseURL: String {
    case baseURL = "https://api.openweathermap.org/data/2.5/weather"
    case geocodingURL = "http://api.openweathermap.org/geo/1.0/direct?"
    case apiKey = "a09fdee06cbe7c4656f62c32dfe319a8"
    case defaultLatLong = "lat=32.97&lon=96.83"
//    http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid=a09fdee06cbe7c4656f62c32dfe319a8
//    "http://api.openweathermap.org/geo/1.0/direct?q=Dallas,{state code},{country code}&limit={limit}&appid={API key}"
}

protocol RequestProtocol {
    associatedtype ResponseType: Decodable
    var url: String { get }
    var parameters: [String: Any] { get }
    var method: HTTPMethod { get }
}

struct APIClient {

    typealias APIClientCompletion = (Decodable?, Data?, APIError?) -> Void
    typealias APIClientDownloadCompletion = (HTTPURLResponse?, UIImage?, APIError?) -> Void

    private let session = URLSession.shared
    static let baseURL = BaseURL.baseURL.rawValue

    func request<Request: RequestProtocol>(_ request: Request, _ completion: @escaping APIClientCompletion) {
        guard let url = URL(string: request.url) else {
            completion(nil, nil, .invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let _ = response as? HTTPURLResponse,
                  let unwrappedData = data  else {
                completion(nil, nil, .requestFailed)
                return
            }
            do {
                let response = try JSONDecoder().decode(Request.ResponseType.self, from: unwrappedData)
                completion(response, data, nil)
            }
            catch {
                completion(nil, nil, .parsingFailed)
            }
        }
        task.resume()
    }

    func download(method: HTTPMethod, urlString: String, _ completion: @escaping APIClientDownloadCompletion) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else {
            completion(nil, nil, .invalidURL)
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                  let mimeType = httpResponse.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    completion(nil, nil, .requestFailed)
                    return
            }

            completion(httpResponse, image, nil)
        }
        task.resume()
        return task
    }
}
