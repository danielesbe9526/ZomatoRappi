//
//  APIRouter.swift
//  ZomatoRappi
//
//  Created by Usuario1 on 10/9/19.
//  Copyright © 2019 danielBeltran. All rights reserved.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    case getRestautantsCloser(latitud: Float, longitude: Float)
    
    private var method: HTTPMethod {
        switch self {
        case .getRestautantsCloser:
            return .post
        }
    }

    // MARK : - Path
    private var fullURL: String {
        switch self {
        case .getRestautantsCloser(latitud: let lat, longitude: let long):
            return ""
        
        }
    }
    
    // MARK: - Parameters
    
    private var parameters: Parameters? {
        switch self {
        case .getRestautantsCloser(latitud: let lat, longitude: let long):
            return ["":""]
        }
    }
    
    func getHeader(_ key: String) -> String {
        guard let value = (Bundle.main.infoDictionary?[key] as? String)?.replacingOccurrences(of: "\"", with: "") else {
            return ""
        }
        
        return value
    }
    
    private var headers: [String: String] {
        
        let userKey = getHeader("userKey")
        let header = ["user-key": userKey]
        
        switch self {
        case .getRestautantsCloser(latitud: _, longitude: _):
            return header
        }
    }
    
    // MARK: -UrlRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try fullURL.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        urlRequest.httpMethod = method.rawValue
        
        for header in headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
    
}

