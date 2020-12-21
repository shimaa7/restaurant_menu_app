//
//  Menu.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/19/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object, Decodable, Comparable{
    
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    
    override init() {}
    
    init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
    
    static func < (lhs: Category, rhs: Category) -> Bool {
        guard let first: String = lhs.name else { return false }
        guard let second: String = rhs.name else { return true }
        
        return first < second
    }
}
