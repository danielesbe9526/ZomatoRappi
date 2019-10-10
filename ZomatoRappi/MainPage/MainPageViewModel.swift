//
//  MainPageViewModel.swift
//  ZomatoRappi
//
//  Created by Usuario1 on 10/9/19.
//  Copyright © 2019 danielBeltran. All rights reserved.
//

import Foundation

class MainPageViewModel {
    
    private let apiClient: APIClientProtocol
    var restaurants = [Restaurant]()
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getRestautants() -> [Restaurant] {
        
        return [
            Restaurant(name: "test1", latitude: 123.2, longitude: 122.0),
            Restaurant(name: "test2", latitude: 1000, longitude: 1999),
            Restaurant(name: "test3", latitude: 340.12, longitude: -134)]
    }
    
    func getCategories(completion: @escaping ([CategoriesDictionary]) -> Void) {
        apiClient.getcategories { (response) in
            switch response {
            case .succes(let categories):
                completion(categories.categories)
                print("succes")
            case .failure(let error):
//                Error Handling
                print(error)
            }
        }
    }
}
