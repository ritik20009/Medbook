//
//  DRNetworkManager.swift
//  MedBook
//
//  Created by Ritik Raj on 12/08/23.
//

import Foundation

public class DRNetworkManager {
    public static let shared = DRNetworkManager()
    
    private init() { }
    
    private func getUrlRequestFromAPI(_ api: API) -> URLRequest? {
        var components = URLComponents()
        components.scheme = api.scheme
        components.host = api.baseUrl
        components.path = api.path
        
        
        if let queryParam = api.queryParam {
            var urlQueryItems:[URLQueryItem] = []
            queryParam.forEach{ element in
                let URLQueryItem = URLQueryItem(name: element.key, value: element.value)
                urlQueryItems.append(URLQueryItem)
            }
            components.queryItems = urlQueryItems
        }
        
        
        guard let url = components.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.method.rawValue
        urlRequest.allHTTPHeaderFields = api.headers
        urlRequest.httpBody = nil
        
        return urlRequest
    }
    
    public func fetchResponse<T: Decodable>(api: API, completion: @escaping (T?) -> Void) {
        guard let urlRequest = getUrlRequestFromAPI(api) else {
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print("error")
                return
            }
            guard let data = data else {
                return
            }
            let decoder = JSONDecoder()
            let object = try? decoder.decode(T.self, from:data)
            DispatchQueue.main.async(execute:{ () -> Void in
                completion(object)
            })
        }).resume()
    }
}

public protocol API {
    var scheme: String { get }
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParam: [String: String]? { get }
    var headers: [String: String]?  { get }
    var body: [String: String]? { get }
}

public extension API {
    var baseUrl: String {
        return "api.first.org"
    }
    
    var scheme: String {
        return "https"
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var body: [String: String]? {
        return nil
    }
    
    var headers: [String: String]? {
        return [:]
    }
}

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}
