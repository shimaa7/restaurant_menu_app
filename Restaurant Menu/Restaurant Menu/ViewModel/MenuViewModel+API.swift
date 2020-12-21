//
//  MenuViewModel+API.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/21/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation

extension MenuViewModel{
    
    func fetchMenuFromAPI(){
                
        // GCD to get categories and products in parallel
        let queue = DispatchQueue(label: "fetchMenu", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
        let group = DispatchGroup()
        
        queue.async(group: group) {
                    
            group.enter()

            Service_URLSession.shared.fetchCategories(completion: { [weak self] (categories, err) in
                if categories != nil{
                    self?.categoriesViewModel = categories!.map({
                        return CategoryViewModel(category: $0)
                    })
                }
                
                group.leave()
            })
            
            group.enter()

            Service_URLSession.shared.fetchProducts(completion: { (products, err) in

                if products != nil{
                    self.productsViewModel = products!.map({
                        return ProductViewModel(product: $0)
                    })
                }
                group.leave()
            })
        }
        
        // notify when get all services data "Menu"
        group.notify(queue: queue) {

            if self.categoriesViewModel != nil && self.productsViewModel != nil
            {
                if !self.categoriesViewModel!.isEmpty && !self.productsViewModel!.isEmpty{

                    let categories: [Category] = self.categoriesViewModel!.map({
                        return $0.category
                    })
                    let products: [Product] = self.productsViewModel!.map({
                        return $0.product
                    })

                    // save data to storage
                    self.storage.write(categories)
                    self.storage.write(products)
                    UserDefaults.standard.set(true, forKey: "isAppLaunchedBefore")

                    self.menuViewModelDelegate?.didFinishFetchingMenu(success: true)

                }else{

                    self.menuViewModelDelegate?.didFinishFetchingMenu(success: false)
                }

            }else{

                self.menuViewModelDelegate?.didFinishFetchingMenu(success: false)
            }
        }
        
    }
}
