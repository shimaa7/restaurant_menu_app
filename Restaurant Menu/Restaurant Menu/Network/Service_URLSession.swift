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

    func fetchCategories(page: Int = 1, completion: @escaping ([Category]?, Error?) -> ()) {
        
        let request = API(url: Constants.CATEGORIES, page: page).get()
        
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            
            if let err = err {
                completion(nil, err)
                print("Failed to fetch categories:", err)
                return
            }
            
            // check response
            guard let data = data else { return }
             if let jsonString = String(data: data, encoding: .utf8) {
                //print(jsonString)
             }
            do {
               let res = try JSONDecoder().decode(CategoryResponse.self, from: data)
                print(res.data.count)

                completion(res.data, err)
//                if res.meta.current_page == res.meta.last_page{
//                    completion(res.data, err)
//                }else{
//                    self.fetchCategories(page: (res.meta.current_page ?? 0) + 1) { (categories, err) in
//                        print("QQ", categories?.count)
//                        completion(res.data, err)
//                    }
//                }
            } catch let error {
               print("Failed to decode:", error)
                completion(nil, error)
            }
            
        }.resume()
    }
    
    func fetchProducts(completion: @escaping ([Product]?, Error?) -> ()) {
        
        let request = API(url: Constants.PRODUCTS, page: 1).get()
        
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            
            if let err = err {
                completion(nil, err)
                print("Failed to fetch categories:", err)
                return
            }
            
            // check response
            guard let data = data else { return }
             if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
             }
            do {
               let res = try JSONDecoder().decode(ProductResponse.self, from: data)
                print(res.data.count)
                completion(res.data, err)
            } catch let error {
               print("Failed to decode:", error)
               completion(nil, error)
            }
            
        }.resume()
    }
}
