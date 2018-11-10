//
//  GetUserInfo.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 25..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import Foundation

//MARK: 사용자 정보

class UserInfo{
    class func getUid() -> String {
        let UUID = UserDefaults.standard.object(forKey: "uuid") as? String
        
        if UUID == nil {
            let createUuid : CFUUID = CFUUIDCreate(nil)
            let string: CFString = CFUUIDCreateString(nil, createUuid)
            UserDefaults.standard.setValue(string, forKey: "uuid")
        }
        
        return UUID ?? ""
    }
}
