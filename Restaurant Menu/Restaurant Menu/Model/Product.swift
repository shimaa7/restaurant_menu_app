//
//  Product.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/19/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation
import RealmSwift

class Product: Object, Decodable{
    
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var categoryID: String?
    @objc dynamic var price: Double = 0
    @objc dynamic var imageURL: String?
    
    override init() {
        
    }
    
    init(id: String?, name: String?, categoryID: String?, price: Double, imageURL: String?){
        self.id = id
        self.name = name
        self.categoryID = categoryID
        self.price = price
        self.imageURL = imageURL
    }
}
