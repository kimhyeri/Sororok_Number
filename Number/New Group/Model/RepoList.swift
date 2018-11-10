//
//  repoList.swift
//  Number
//
//  Created by hyerikim on 2018. 9. 5..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import Foundation
import SwiftyJSON

struct repoListSet {
    lazy var dataList = Array<repoList>()
    init(rawJson: Any) {
        let json = JSON(rawJson)
        for data in json.arrayValue {
            dataList.append(repoList(rawJson: data))
        }
    }
}

struct repoList {
    
    let joinFlag : Int
    let name : String
    let repositoryId : Int
    let authority : Int
    let imageName : String
    let extra_info : String
    
    init(rawJson: Any){
        let json = JSON(rawJson)
        
        joinFlag = json["joinFlag"].intValue
        name = json["name"].stringValue
        repositoryId = json["repositoryId"].intValue
        authority = json["authority"].intValue
        imageName = json["imageName"].stringValue
        extra_info = json["extra_info"].stringValue
    }
    
}
