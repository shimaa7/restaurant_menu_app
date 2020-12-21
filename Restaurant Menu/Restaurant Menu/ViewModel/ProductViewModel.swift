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
    let image: String
    let price: Double
    let categoryViewModel: CategoryViewModel
    
    var productViewModelDelegate: ProductViewModelDelegate?
    
    init(product: Product){
        name = product.name ?? "Product"
        image = product.image ?? ""
        price = product.price
        categoryViewModel = product.category.map({return CategoryViewModel(category: $0)}) ?? CategoryViewModel(category: Category())
    }
    
    static func == (lhs: ProductViewModel, rhs: ProductViewModel) -> Bool {
        return lhs.name == rhs.name ? lhs.image == rhs.image ? true : false : false
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
