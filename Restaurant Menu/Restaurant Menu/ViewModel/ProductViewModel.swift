//
//  ProductViewModel.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/19/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation

protocol ProductViewModelDelegate {
    
    func didStartFetchingProducts()
    func didFinishFetchingProducts(products: [Product]?)
}

class ProductViewModel: Equatable{
    
    let name: String
    let imageURL: String
    let categoryViewModel: CategoryViewModel
    
    var productViewModelDelegate: ProductViewModelDelegate?
    
    init(product: Product){
        name = product.name ?? "Product"
        imageURL = product.imageURL ?? ""
        categoryViewModel = product.category.map({return CategoryViewModel(category: $0)}) ?? CategoryViewModel(category: Category())
    }
    
    static func == (lhs: ProductViewModel, rhs: ProductViewModel) -> Bool {
        return lhs.name == rhs.name ? lhs.imageURL == rhs.imageURL ? true : false : false
    }
    
    func fetchProducts(){
        
        productViewModelDelegate?.didStartFetchingProducts()
        
        Service_URLSession.shared.fetchProducts(completion: { (products, err) in
            
            if products != nil{
                self.productViewModelDelegate?.didFinishFetchingProducts(products: products)
            }
        })
    }
}
