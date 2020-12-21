//
//  API.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/19/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation
import Alamofire

class API {
    
    var request: URLRequest
    
    init(url: String, page: Int = 1) {
        if url.contains("?"){
            request = URLRequest(url: URL(string: url + "&page=\(page)")!)
        }else{
            request = URLRequest(url: URL(string: url + "?page=\(page)")!)
        }
    }
    
    func get() -> URLRequest{
        
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(Constants.TOKEN)", forHTTPHeaderField: "Authorization")

        return request
    }
    
}
