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
    
    init(categoriesViewModel: [CategoryViewModel], productsViewModel: [ProductViewModel]){
        self.categoriesViewModel = categoriesViewModel
        self.productsViewModel = productsViewModel
    }
    
    func fetchMenu(){
        
        //print(storage.getFileURL())
        
        // choose menu data location
        let isAppLaunchedBefore = UserDefaults.standard.bool(forKey: "isAppLaunchedBefore")

        if !isAppLaunchedBefore {

            // start fetching data from API
            menuViewModelDelegate?.didStartFetchingMenu(message: Message.DOWNLOADING.rawValue)

            // app first launch
            fetchMenuFromAPI()
            storage.deleteAll()
            
        }else{
            
            // start fetching data from local storage
            menuViewModelDelegate?.didStartFetchingMenu(message: Message.LOADING.rawValue)

            // app launch before
            fetchMenuFromStorage()
        }
    }
    
    func fetchMenuFromStorage(){
                
        // fetch categories and products
        let categories: [Category] = storage.objects()
        let products: [Product] = storage.objects()
                        
        // map models to view models and set data
        self.categoriesViewModel = categories.map({return CategoryViewModel(category: $0)})
        self.productsViewModel = products.map({return ProductViewModel(product: $0)})

        self.menuViewModelDelegate?.didFinishFetchingMenu(success: true)

    }
    
    func getProductsForSelectedCategory(categoryID: String) -> [ProductViewModel]?{

        let productsViewModel = self.productsViewModel?.filter({ (productViewModel) -> Bool in
            return productViewModel.product.categoryID == categoryID
        })
        
        return productsViewModel
    }
    
}
