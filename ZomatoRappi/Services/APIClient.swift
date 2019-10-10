//
//  APIClient.swift
//  ZomatoRappi
//
//  Created by Usuario1 on 10/9/19.
//  Copyright © 2019 danielBeltran. All rights reserved.
//

import Foundation
import Alamofire

enum APIError  {
    case connectionError(Error)
    case authorizationError(Error)
    case serverError(Error)
    case clientError(Error)
}

enum Response<Value> {
    case succes(Value)
    case failure(APIError)
}

protocol APIClientProtocol {
    func getcategories(completion: @escaping (Response<Categories>) -> Void )
}

final class APIClient: APIClientProtocol {
    
    func getcategories(completion: @escaping (Response<Categories>) -> Void) {
        sessionManager.request(APIRouter.getCategories())
            .validate(statusCode: 200..<300)
            .responseJSON{ (jsonResponse) in
                self.handleJSONResponse(response: jsonResponse, decodeType: Categories.self, completion: completion)
        }
    }
    
    let sessionManager = SessionManager()
    
    // MARK: - JSON Handling
    
    private func handleJSONResponse<Value:Decodable>(response: DataResponse<Any>, decodeType: Value.Type, completion: (Response<Value>) -> Void) {
        guard let jsonData = response.data else {
            guard let serviceError = response.error,
                let statusCode = response.response?.statusCode else { return }
            handleError(statusCode: statusCode, error: serviceError, withCompletion: completion)
            return
        }
        
        do {
            let parsedObjects = try JSONDecoder().decode(decodeType.self, from: jsonData)
            completion(Response.succes(parsedObjects))
        } catch let error {
            handleError(statusCode: response.response?.statusCode, error: error, withCompletion: completion)
        }
    }
    
    // MARK: - Error Handling
    
    private func handleError<Value>(statusCode: Int?, error: Error, withCompletion completion: (Response<Value>) -> Void) {
        if let statusCode = statusCode {
            switch statusCode {
            case 400..<452:
                completion(.failure(.authorizationError(error)))
            case 500..<512:
                completion(.failure(.serverError(error)))
            default:
                completion(.failure(.connectionError(error)))
            }
        }
    }
    
    private func sanitizeString(string: String) -> String {
        guard let sanitizedString = string.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else { return String() }
        return sanitizedString
    }
    
}
