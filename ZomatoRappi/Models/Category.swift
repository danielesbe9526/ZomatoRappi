//
//  Category.swift
//  ZomatoRappi
//
//  Created by Daniel Beltran on 10/10/19.
//  Copyright © 2019 danielBeltran. All rights reserved.
//

import Foundation

struct Categories: Codable {
    let categories:  [CategoriesDictionary]
}

struct CategoriesDictionary: Codable {
    let categories : Category
    
}

struct Category: Codable {
    let id : Int
    let name: String

}
