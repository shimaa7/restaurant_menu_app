//
//  CategoriesViewModel.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/19/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation

struct CategoryViewModel{
    
    let name: String
    
    init(category: Category){
        name = category.name ?? "Category"
    }
}

