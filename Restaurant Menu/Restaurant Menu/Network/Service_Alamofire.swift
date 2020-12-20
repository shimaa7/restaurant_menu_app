//
//  Service_Alamofire.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/20/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Service_Alamofire: NSObject {
    
    static let shared = Service_Alamofire()

    func fetchCategories(completion: @escaping ([Category]?, Error?) -> ()) {
        
        let request = API(url: Constants.CATEGORIES, page: 1).get()
        
        AF.request(request).responseJSON {
            
            response in
            
            //print(response)
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print(json)
                let data = json["data"].arrayValue
                let meta = json["meta"].dictionary
                
//                for category in data{
//                    self.categoriesAPI.append(Category(id: category["id"].stringValue,
//                                                  name: category["name"].stringValue))
//                }
//                print(self.categoriesAPI.count)
//                if meta?["current_page"]?.intValue == meta?["last_page"]?.intValue{
//                    self.page = 1
//                    //self.isFirstLaunch = false
//                    //self.categoriesCollectionView.reloadData()
//                    self.getProductsData()
//                    print("Donnnnne")
//                }else{
//                    print("NOOOO")
//                    self.page += 1
//                    self.getCategoriesData()
//                }

            case .failure(let error):
                print(error)
//                self.categoriesAPI.removeAll()
//                self.productsAPI.removeAll()
//                self.showFailedToDownloadDate()
            }

        }
        
    }
    
    func fetchProducts(completion: @escaping ([Product]?, Error?) -> ()) {
        
        let request = API(url: Constants.PRODUCTS, page: 1).get()
        
        AF.request(request).responseJSON {
            
            response in
            
            //print(response)
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print(json)
                let data = json["data"].arrayValue
                let meta = json["meta"].dictionary
                
//                for product in data{
//                    let category = product["category"].dictionary
//                    self.productsAPI.append(Product(id: product["id"].stringValue, name: product["name"].stringValue, categoryID: category?["id"]?.stringValue, price: product["price"].doubleValue, imageURL: product["image"].stringValue))
//                }
//                print(self.productsAPI.count)
//                if meta?["current_page"]?.intValue == meta?["last_page"]?.intValue{
//                    self.page = 1
//                    self.stopSpinner(onView: self.spinnerView)
//                    self.nextBtn.isUserInteractionEnabled = true
//                    self.previousBtn.isUserInteractionEnabled = true
//                    self.categoriesCollectionView.reloadData()
//                    self.storage.write(self.categoriesAPI)
//                    self.storage.write(self.productsAPI)
//                    UserDefaults.standard.set(true, forKey: "isAppFirstLaunch")
//                    print("DonnnnnePP")
//                }else{
//                    print("NOOOOPP")
//                    self.page += 1
//                    self.getProductsData()
//                }

            case .failure(let error):
                print(error)
//                self.categoriesAPI.removeAll()
//                self.productsAPI.removeAll()
//                self.showFailedToDownloadDate()
            }

        }
    }
}
