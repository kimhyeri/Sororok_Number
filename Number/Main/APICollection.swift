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
    
    //MARK: user api
    
    //회원가입 되어있는지 확인
    func registeredCheck(parameters: Parameters ,completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)member/login", method: .post, parameters: parameters as [String: Any], encoding: JSONEncoding.default, headers: [:])
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
    
    //회원가입
    func register(parameters: Parameters, completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)member/join", method: .put, parameters: parameters as [String:Any], encoding: JSONEncoding.default).responseJSON {
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
    
    //유저 정보 확인
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
    
    //유저 새소식 확인
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
    
    //회원탈퇴
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
    
    
    //MARK: group api
    
    //유저가 가입된 그룹 조회
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
    
    //유저가 그룹에 가입되어있는지 확인 가입
    func checkRepoJoin(parameter: Parameters, completion: @escaping (_ result: JSON) -> (Void)){
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
    
    //새로운 코드번호 받기
    func createCode(completion: @escaping (_ result: JSON) -> (Void)){
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
    
    //그룹명으로 그룹 검색하기
    func searchRepo(parameter : Parameters, completion: @escaping (_ result: JSON) -> (Void)){
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
    
    //그룹장 - 그룹없애기
    func destroyRepo(parameters: Parameters ,completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)repository/destroy", method: .post, parameters: parameters as [String: Any], encoding: JSONEncoding.default, headers: [:])
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
    
    //멤버 - 그룹 나가기
    func exitRepo(parameters: Parameters ,completion: @escaping (_ result: JSON) -> (Void)){
        Alamofire.request("\(url)repository/exit", method: .post, parameters: parameters as [String: Any], encoding: JSONEncoding.default, headers: [:])
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
    
    //그룹에 가입된 멤버들 조회하기
    func getRepoMember(parameter : Parameters, completion: @escaping (_ result: JSON) -> (Void)){
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
    
    //그룹내에서 멤버 찾기
    func searchMember(parameter : Parameters, completion: @escaping (_ result: JSON) -> (Void)){
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
    
    //그룹에 대한 정보 얻기
    func getRepoInfo(parameter : Parameters, completion: @escaping (_ result: JSON) -> (Void)){
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
    
    //그룹정보 수정
    func updateRepo(parameter: Parameters, completion: @escaping (_ result: JSON) -> (Void)){
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

