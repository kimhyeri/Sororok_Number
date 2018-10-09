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
    let imageUrl = "http://45.63.120.140:40005/sororok/images/"
    
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
        
        Alamofire.request("\(url)member/info", method: .get, parameters: parameter).responseJSON {
            
            response in
            let json = JSON(response.result.value)
            print(json)
            switch response.result {
            case .success:
                print("success")
                completion(json)
                UserDefaults.standard.set(json.array, forKey: "userInfo")
            case .failure:
                print("fail")
                break
            }
        }
    }
    
    func memberHistory(parameter: Parameters, completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)member/history", method: .get, parameters: parameter).responseJSON {
            response in
            let json = JSON(response.result.value)
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
    
    func memberRemove(parameter: Parameters, completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)member/remove", method: .put, parameters: parameter, encoding: JSONEncoding.default, headers: [:]).responseJSON {
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
    
    func repoList(parameter: Parameters, completion: @escaping (_ ruslt: JSON) -> (Void)){
        Alamofire.request("\(url)repository/list", method: .get, parameters: parameter).responseJSON {
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
    
    func checkRepoJoin (parameter: Parameters, completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)repository/join", method: .put, parameters: parameter, encoding: JSONEncoding.default, headers: [:]).responseJSON {
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
    
    func createCode (completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)repository/code").responseJSON { response in
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
    
    func searchRepo (parameter : Parameters, completion: @escaping (_ result: JSON) -> (Void)){
         Alamofire.request("\(url)repository/search", method: .get, parameters: parameter).responseJSON { response in
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
    
    func destroyRepo(parameters: Parameters ,completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)repository/destroy", method: .post, parameters: parameters as? [String: Any], encoding: JSONEncoding.default, headers: [:])
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
    
    func exitRepo(parameters: Parameters ,completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)repository/exit", method: .post, parameters: parameters as? [String: Any], encoding: JSONEncoding.default, headers: [:])
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
    
    func getRepoMember (parameter : Parameters, completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)repository/detail", method: .get, parameters: parameter).responseJSON { response in
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
    
    func searchMember (parameter : Parameters, completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)repository/memberSearch", method: .get, parameters: parameter).responseJSON { response in
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
    
    func getRepoInfo (parameter : Parameters, completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)repository/info", method: .get, parameters: parameter).responseJSON { response in
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
    
    func updateRepo (parameter: Parameters, completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)repository/update", method: .put, parameters: parameter, encoding: JSONEncoding.default, headers: [:]).responseJSON {
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
}

