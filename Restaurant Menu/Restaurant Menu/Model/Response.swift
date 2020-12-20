//
//  Response.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/20/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation

struct CategoryResponse: Decodable {
    
    var data : [Category]
    var meta: Meta
}

struct ProductResponse: Decodable {
    
    var data : [Product]
    var meta: Meta
}

struct Meta: Decodable{
    
    var current_page: Int?
    var last_page: Int?  
}
