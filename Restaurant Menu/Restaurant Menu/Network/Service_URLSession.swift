//
//  Service.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/19/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation

class Service_URLSession: NSObject {
    
    static let shared = Service_URLSession()
    private static var categoriesArr = [Category]()
    private static var productsArr = [Product]()

        
    func fetchCategories(page: Int = 1, completion: @escaping ([Category]?, Error?) -> ()) {
        
        let request = API(url: Constants.CATEGORIES, page: page).get()
                
        URLSession.shared.dataTask(with: request) { [weak self] (data, resp, err) in
                        
            if let err = err {
                print("Failed to fetch categories:", err)
                completion(nil, err)
                return
            }
            
            // check response
            guard let data = data else { return }
             if let _ = String(data: data, encoding: .utf8) {
                //print(jsonString)
             }
            
            do {
                
               let res = try JSONDecoder().decode(CategoryResponse.self, from: data)
                
                DispatchQueue.main.async {
                    
                    Service_URLSession.categoriesArr.append(contentsOf: res.data)

                }
                
                // GCD to get all categories from different pages
                let queue = DispatchQueue(label: "fetchCategories", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
                let group = DispatchGroup()

                queue.async(group: group) {

                    if page + 1 <= res.meta.last_page!{

                        for pageNumber in (page + 1)...res.meta.last_page!{

                            group.enter()
                            
                            let subRequest = API(url: Constants.CATEGORIES, page: pageNumber).get()
                            
                            URLSession.shared.dataTask(with: subRequest) { (data, resp, err) in
                                
                                if let err = err {
                                    print("Failed to fetch categories:", err)
                                    completion(nil, err)
                                    return
                                }
                                
                                // check response
                                guard let data = data else { return }
                                 if let _ = String(data: data, encoding: .utf8) {
                                    //print(jsonString)
                                 }
                                
                                do {
                                    
                                   let res = try JSONDecoder().decode(CategoryResponse.self, from: data)
                                    
                                    Service_URLSession.categoriesArr.append(contentsOf: res.data)
                                    
                                    group.leave()
                                    
                                } catch let error {
                                   print("Failed to decode:", error)
                                   completion(nil, error)
                                }
                                
                            }.resume()
                        }
                     }
                  }
                
                group.notify(queue: queue){
                    
                    if res.meta.total == Service_URLSession.categoriesArr.count{
                        completion(Service_URLSession.categoriesArr, err)
                    }else{
                        completion(nil, err)
                    }
                }
                
            } catch let error {
               print("Failed to decode:", error)
               completion(nil, error)
            }
                        
        }.resume()
    }
    
    func fetchProducts(page: Int = 1, completion: @escaping ([Product]?, Error?) -> ()) {
                
        let request = API(url: Constants.PRODUCTS_CATEGORIES_INCLUDED, page: page).get()
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, resp, err) in
            
            if let err = err {
                completion(nil, err)
                print("Failed to fetch products:", err)
                return
            }
            
            // check response
            guard let data = data else { return }
            if let _ = String(data: data, encoding: .utf8) {
                //print(jsonString)
             }
            
            do {
                
               let res = try JSONDecoder().decode(ProductResponse.self, from: data)
                
                DispatchQueue.main.async {
                    
                    Service_URLSession.productsArr.append(contentsOf: res.data)

                }
                
                // GCD to get all categories from different pages
                let queue = DispatchQueue(label: "fetchProducts", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
                let group = DispatchGroup()

                queue.async(group: group) {

                    if page + 1 <= res.meta.last_page!{

                        for pageNumber in (page + 1)...res.meta.last_page!{

                            group.enter()
                            
                            let subRequest = API(url: Constants.PRODUCTS_CATEGORIES_INCLUDED, page: pageNumber).get()
                            
                            URLSession.shared.dataTask(with: subRequest) { (data, resp, err) in
                                
                                if let err = err {
                                    print("Failed to fetch categories:", err)
                                    completion(nil, err)
                                    return
                                }
                                
                                // check response
                                guard let data = data else { return }
                                 if let _ = String(data: data, encoding: .utf8) {
                                    //print(jsonString)
                                 }
                                
                                do {
                                    
                                   let res = try JSONDecoder().decode(ProductResponse.self, from: data)
                                    
                                    Service_URLSession.productsArr.append(contentsOf: res.data)
                                    
                                    group.leave()
                                    
                                } catch let error {
                                   print("Failed to decode:", error)
                                   completion(nil, error)
                                }
                                
                            }.resume()
                        }
                     }
                  }
                
                group.notify(queue: queue){
                    
                    if res.meta.total == Service_URLSession.productsArr.count{
                        completion(Service_URLSession.productsArr, err)
                    }else{
                        completion(nil, err)
                    }
                }
                
            } catch let error {
               print("Failed to decode:", error)
               completion(nil, error)
            }
            
        }.resume()
    }
}
