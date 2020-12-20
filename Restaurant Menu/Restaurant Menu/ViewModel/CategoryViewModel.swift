//
//  CategoriesViewModel.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/19/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation

protocol CategoryViewModelDelegate {
    
    func didStartFetchingCategories()
    func didFinishFetchingCategories(categories: [Category]?)
}

class CategoryViewModel{
    
    let name: String
    
    var categoriesViewModelDelegate: CategoryViewModelDelegate?

    init(category: Category){
        name = category.name ?? "Category"
    }
    
    func fetchCategories(){
        
        categoriesViewModelDelegate?.didStartFetchingCategories()
        
        Service_URLSession.shared.fetchCategories(completion: { (categories, err) in
            
            if categories != nil{
                self.categoriesViewModelDelegate?.didFinishFetchingCategories(categories: categories)
            }
        })
    }
}

