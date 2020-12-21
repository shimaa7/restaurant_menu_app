//
//  Product.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/19/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation
import RealmSwift

class Product: Object, Decodable, Comparable{
    
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var category: Category? //category
    @objc dynamic var price: Double = 0
    @objc dynamic var imageURL: String?
    
    override init() {}
    
    init(id: String?, name: String?, category: Category?, price: Double, imageURL: String?){
        self.id = id
        self.name = name
        self.category = category
        self.price = price
        self.imageURL = imageURL
    }
    
    static func < (lhs: Product, rhs: Product) -> Bool {
        guard let first: String = lhs.name else { return false }
        guard let second: String = rhs.name else { return true }
        
        return first < second
    }
}
