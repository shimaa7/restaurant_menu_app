//
//  MenuViewModel.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/20/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation

enum Message: String{
    
    case DOWNLOADING = "Downloading menu"
    case LOADING = "Loading menu"
}

protocol MenuViewModelDelegate {
    
    func didStartFetchingMenu(message: String)
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
        
        // choose menu data location
        let isAppLaunchedBefore = UserDefaults.standard.bool(forKey: "isAppLaunchedBefore")

        if !isAppLaunchedBefore {

            // start fetching data
            menuViewModelDelegate?.didStartFetchingMenu(message: Message.DOWNLOADING.rawValue)
            print("WEB")
            // app first launch
            fetchMenuFromAPI()
            
        }else{
            
            // start fetching data
            menuViewModelDelegate?.didStartFetchingMenu(message: Message.LOADING.rawValue)
            print("STORAGE")
            // app launch before
            fetchMenuFromStorage()
        }
    }
    
    func fetchMenuFromAPI(){
                
        // GCD to get categories and products in parallel
        let queue = DispatchQueue(label: "fetchMenu", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
        let group = DispatchGroup()
        
        queue.async(group: group) {
                    
            group.enter()

            Service_URLSession.shared.fetchCategories(completion: { [weak self] (categories, err) in
                
                if categories != nil{
                    print("fetchMenu fetchMenu", categories?.count)
                    self?.categoriesViewModel = categories!.map({
                        return CategoryViewModel(category: $0)
                    })
                }
                
                group.leave()
            })
            
            group.enter()

            Service_URLSession.shared.fetchProducts(completion: { (products, err) in

                if products != nil{
                    print("fetchMenummmmmmmmm fetchMenu", products?.count)
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
                    print("%%%%%%11111")
//                    UserDefaults.standard.set(true, forKey: "isAppLaunchedBefore")
                    // save data to storage
    //                storage.write(self.categoriesViewModel)
    //                storage.write(self.productsViewModel)
                    self.menuViewModelDelegate?.didFinishFetchingMenu(success: true)
                    
                }else{
                    
                    self.menuViewModelDelegate?.didFinishFetchingMenu(success: false)
                }
                
            }else{
                
                print("%%%%%%2222")
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
