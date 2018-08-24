//
//  APICollection.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 25..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class APICollection{
    static let sharedAPI = APICollection()
    let url = "45.63.120.140:40005/"
    
    func registeredCheck(parameters: Parameters ,completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)member/login/", method: .post, parameters: parameters).validate(statusCode: 200..<300).responseJSON { response in
            let json = JSON(response.result.value)
            print(json)
            switch response.result {
            case .success:
                completion(json)
                break
            case .failure:
                break
            }
        }
    }
    
    func register(parameters: Parameters, completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)member/join/", method: .put , parameters: parameters).validate(statusCode: 200..<300).responseJSON {
            response in
            let json = JSON(response.result.value)
            print(json)
            switch response.result {
            case .success:
                completion(json)
                break
            case .failure:
                break
            }
        }
    }
}

