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
    func getRestautantsCloser(to latitud: Float, longitude: Float, completion: @escaping (Response<Restaurant>) -> Void )
}

final class APIClient: APIClientProtocol {
    
    let sessionManager = SessionManager()
    
    func getRestautantsCloser(to latitud: Float, longitude: Float, completion: @escaping (Response<Restaurant>) -> Void) {
        sessionManager.request(APIRouter.getRestautantsCloser(latitud: latitud, longitude: longitude))
        .validate(statusCode: 200..<300)
            .responseData { (dataResponse) in
                if let error = dataResponse.error {
                    
                } else {
//                    completion()
                }
        }
    }
    
    
}
