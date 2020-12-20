//
//  MenuViewModel.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/20/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation

protocol MenuViewModelDelegate {
    
    func didStartFetchingMenu()
    func didFinishFetchingMenu(menu: Menu?)
}

class MenuViewModel{
    
    let categories: [Category]
    let products: [Product]
    
    var menuViewModelDelegate: MenuViewModelDelegate?
    
    init(categories: [Category], products: [Product]){
        self.categories = categories
        self.products = products
    }
    
    func fetchProducts(){
        
        menuViewModelDelegate?.didStartFetchingMenu()
        
        Service_URLSession.shared.fetchProducts(completion: { (products, err) in
            
//            if products != nil{
//                self.menuViewModelDelegate?.didFinishFetchingMenu(menu: products)
//            }
        })
    }
}
