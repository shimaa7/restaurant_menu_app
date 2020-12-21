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
    private static var productsArr2 = [SynchronizedArray<Product>]()

        
    func fetchCategories(page: Int = 1, completion: @escaping ([Category]?, Error?) -> ()) {
        
        //print("&&&&&&&", page)

        let request = API(url: Constants.CATEGORIES, page: page).get()
        
        print("E####")
        
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
                
                completion(res.data, err)
                
//                // GCD to get all categories from different pages
//                let queue = DispatchQueue(label: "fetchCategories", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
//                let group = DispatchGroup()
//
//                queue.async(group: group) {
//
//                    if page + 1 <= res.meta.last_page!{
//
//                        for pageNumber in (page + 1)...res.meta.last_page!{
//
//                            group.enter()
//                            self?.fetchCategories(page: pageNumber) { (categories, err) in
//                                group.leave()
//                            }
//                        }
//                     }
//                  }
//
//                  // notify when get all categories and return
//                  group.notify(queue: queue) {
//                        //print(page, res.data.count)
//                        Service_URLSession.categoriesArr.append(contentsOf: res.data)
//                        Service_URLSession.categoriesArr.sort()
//                        completion(Service_URLSession.categoriesArr, err)
//                   }
                
            } catch let error {
               print("Failed to decode:", error)
               completion(nil, error)
            }
                        
        }.resume()
    }
    
    func fetchProducts(page: Int = 1, completion: @escaping ([Product]?, Error?) -> ()) {
        
        print("#####", page)
        
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
               print(res)
               completion(res.data, err)
                
//                // GCD to get all categories from different pages
//                let queue = DispatchQueue(label: "fetchProducts", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
//                let group = DispatchGroup()
//
//                queue.async(group: group) {
//
//                    let last = 5
//
//                    if page + 1 <= last{
//
//                        for pageNumber in (page + 1)...last{
//
//                            group.enter()
//                            self?.fetchProducts(page: pageNumber) { (_, err) in
//                                group.leave()
//                            }
//                        }
//                     }
//                  }
//
//                  // notify when get all categories and return
//                  group.notify(queue: queue) {
//                        //print(page, res.data.count)
//                        Service_URLSession.productsArr.append(contentsOf: res.data)
//                        Service_URLSession.categoriesArr.sort()
//                        completion(Service_URLSession.productsArr, err)
//                   }
                
            } catch let error {
               print("Failed to decode:", error)
               completion(nil, error)
            }
            
        }.resume()
    }
}

public class SynchronizedArray<T> {
private var array: [T] = []
private let accessQueue = DispatchQueue(label: "SynchronizedArrayAccess", attributes: .concurrent)

public func append(newElement: T) {

    self.accessQueue.async(flags:.barrier) {
        self.array.append(newElement)
    }
}
    
public func append(newElements: [T]) {

    self.accessQueue.async(flags:.barrier) {
        self.array.append(contentsOf: newElements)
    }
}

public func removeAtIndex(index: Int) {

    self.accessQueue.async(flags:.barrier) {
        self.array.remove(at: index)
    }
}

public var count: Int {
    var count = 0

    self.accessQueue.sync {
        count = self.array.count
    }

    return count
}

public func first() -> T? {
    var element: T?

    self.accessQueue.sync {
        if !self.array.isEmpty {
            element = self.array[0]
        }
    }

    return element
}

public subscript(index: Int) -> T {
    set {
        self.accessQueue.async(flags:.barrier) {
            self.array[index] = newValue
        }
    }
    get {
        var element: T!
        self.accessQueue.sync {
            element = self.array[index]
        }

        return element
    }
}
}

