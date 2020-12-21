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

                let data = json["data"].arrayValue
                let meta = json["meta"].dictionary

            case .failure(let error):
                print(error)
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

                let data = json["data"].arrayValue
                let meta = json["meta"].dictionary
            

            case .failure(let error):
                print(error)
            }

        }
    }
}
