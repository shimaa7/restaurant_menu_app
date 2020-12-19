//
//  ProductViewModel.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/19/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation

struct ProductViewModel: Equatable{
    
    let name: String
    let imageURL: String
        
    init(product: Product){
        name = product.name ?? "Product"
        imageURL = product.imageURL ?? ""
    }
}
