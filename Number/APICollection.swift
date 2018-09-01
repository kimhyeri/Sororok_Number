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
    let url = "http://45.63.120.140:40005/"
    
    func registeredCheck(parameters: Parameters ,completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)member/login", method: .post, parameters: parameters as? [String: Any], encoding: JSONEncoding.default, headers: [:])
            .responseJSON { response in
                let json = JSON(response.result.value)
                print(json)
                switch response.result {
                case .success:
                    completion(json)
                    break
                case .failure:
                    print("fail")
                    break
                }
        }
    }
    
    func register(parameters: Parameters, completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)member/join", method: .put, parameters: parameters as? [String:Any], encoding: JSONEncoding.default).responseJSON {
            response in
            let json = JSON(response.result.value)
            print(json)
            switch response.result {
            case .success:
                print("success")
                completion(json)
                break
            case .failure:
                print("fail")
                break
            }
        }
    }
    
    func checkMemberInfo(parameter: Parameters, completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("http://45.63.120.140:40005/member/info", method: .get, parameters: parameter).responseJSON {
            response in
            let json = JSON(response.result.value)
            print(json)
            switch response.result {
            case .success:
                print("success")
                break
            case .failure:
                print("fail")
                break
            }
        }
    }
    
    func memberHistory(parameter: Parameters, completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("http://45.63.120.140:40005/member/history", method: .get, parameters: parameter).responseJSON {
            response in
            let json = JSON(response.result.value)
            print(json)
            switch response.result {
            case .success:
                print("success")
                break
            case .failure:
                print("fail")
                break
            }
        }
    }
}

