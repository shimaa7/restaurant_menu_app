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
    @objc dynamic var categoryID: String = ""
    @objc dynamic var price: Double = 0
    @objc dynamic var image: String?
    var category: Category?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case category
        case price
        case image
    }
    
    override init() {
    }
    
    init(id: String?, name: String?, category: Category?, price: Double, image: String?){
        self.id = id
        self.name = name
        self.category = category
        self.price = price
        self.image = image
        self.categoryID = category?.id ?? ""
    }
    
    static func < (lhs: Product, rhs: Product) -> Bool {
        guard let first: String = lhs.name else { return false }
        guard let second: String = rhs.name else { return true }
        
        return first < second
    }
}
