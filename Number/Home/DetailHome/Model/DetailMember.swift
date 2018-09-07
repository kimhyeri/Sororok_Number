//
//  DetailMember.swift
//  Number
//
//  Created by hyerikim on 2018. 9. 6..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DetailMember {
    let phone : String
    let name : String
    let email : String
    let imageName : String
    let memberId : Int
    let authority : Int
    
    init(rawJson: Any) {
        let json = JSON(rawJson)
        
        phone = json["phone"].stringValue
        name = json["name"].stringValue
        email = json["email"].stringValue
        imageName = json["imageName"].stringValue
        memberId = json["memberId"].intValue
        authority = json["authority"].intValue
    }
}

struct DetailMemberSet {
    lazy var memberList = Array<DetailMember>()
    init(rawJson: Any) {
        let json = JSON(rawJson)
        for data in json.arrayValue {
            memberList.append(DetailMember(rawJson: data))
        }
    }
}
