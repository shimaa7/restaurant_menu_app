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
    func didFinishFetchingMenu()
}

class MenuViewModel{
    
    var categoriesViewModel: [CategoryViewModel]
    var productsViewModel: [ProductViewModel]
    
    var menuViewModelDelegate: MenuViewModelDelegate?
    
    init(categories: [CategoryViewModel], products: [ProductViewModel]){
        self.categoriesViewModel = categories
        self.productsViewModel = products
    }
    
    func fetchMenu(){
        
        menuViewModelDelegate?.didStartFetchingMenu()
        
        Service_URLSession.shared.fetchCategories(completion: { (categories, err) in
            
            if categories != nil{
                print("fetchMenu fetchMenu",categories?.count)
                self.categoriesViewModel = categories!.map({
                    return CategoryViewModel(category: $0)
                })
                self.menuViewModelDelegate?.didFinishFetchingMenu()
            }
        })
        
//        Service_URLSession.shared.fetchProducts(completion: { (products, err) in
//
//            if products != nil{
//                self.productsViewModel = products!.map({
//                    return ProductViewModel(product: $0)
//                })
//            }
//        })
    }
}
