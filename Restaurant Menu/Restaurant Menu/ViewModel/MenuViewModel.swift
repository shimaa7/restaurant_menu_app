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
    func didFinishFetchingMenu(success: Bool)
}

class MenuViewModel{
    
    var categoriesViewModel: [CategoryViewModel]?
    var productsViewModel: [ProductViewModel]?
    let storage: LocalStorageProtocol = LocalStorage()

    var menuViewModelDelegate: MenuViewModelDelegate?
    
    init(categories: [CategoryViewModel], products: [ProductViewModel]){
        self.categoriesViewModel = categories
        self.productsViewModel = products
    }
    
    func fetchMenu(){
        
        // start fetching data
        menuViewModelDelegate?.didStartFetchingMenu()
        
        // choose menu data location
        let isAppLaunchedBefore = UserDefaults.standard.bool(forKey: "isAppLaunchedBefore")
        
        if !isAppLaunchedBefore {
            
            // app first launch
            fetchMenuFromAPI()
            
        }else{
            
            // app launch before
            fetchMenuFromStorage()
        }
    }
    
    func fetchMenuFromAPI(){
        
        // GCD to get categories and products in parallel
        let queue = DispatchQueue(label: "fetchMenu", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
        let group = DispatchGroup()
        
        queue.async(group: group) {
                    
//            group.enter()
//
//            Service_URLSession.shared.fetchCategories(completion: { [weak self] (categories, err) in
//                
//                if categories != nil{
//                    print("fetchMenu fetchMenu",categories?.count)
//                    self?.categoriesViewModel = categories!.map({
//                        return CategoryViewModel(category: $0)
//                    })
//                }
//                group.leave()
//            })
            
            group.enter()
            
            Service_URLSession.shared.fetchProducts(completion: { (products, err) in

                if products != nil{
                    print("fetchMenummmmmmmmm fetchMenu",products?.count)
                    self.productsViewModel = products!.map({
                        return ProductViewModel(product: $0)
                    })
                }
                group.leave()
            })
        }
        
        // notify when get all services data "Menu"
        group.notify(queue: queue) {
            
            if self.productsViewModel != nil && self.categoriesViewModel != nil {
                
                self.menuViewModelDelegate?.didFinishFetchingMenu(success: true)
                
            }else{
                
                self.menuViewModelDelegate?.didFinishFetchingMenu(success: false)
            }
        }
        
    }
    
    func fetchMenuFromStorage(){
        
        // fetch categories and products
        let categories: [Category] = storage.objects()
        let products: [Product] = storage.objects()
        
        // map models to view models and set data
        self.categoriesViewModel = categories.map({return CategoryViewModel(category: $0)})
        self.productsViewModel = products.map({return ProductViewModel(product: $0)})
        
    }
    
    func getProductsForSelectedCategoryViewModel(categoryViewModel: CategoryViewModel) -> [ProductViewModel]?{
        
        let productsViewModel = self.productsViewModel?.filter({ (productViewModel) -> Bool in
            return productViewModel.categoryViewModel == categoryViewModel
        })
        
        return productsViewModel
    }
    
    
}
