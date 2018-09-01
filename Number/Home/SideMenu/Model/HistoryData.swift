//
//  HistoryData.swift
//  Number
//
//  Created by hyerikim on 2018. 9. 2..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import Foundation
import SwiftyJSON

struct HistoryData {
    let content : String
    let date : String
    let seq_no : Int
    
    init(rawJson: Any) {
        let json = JOSN(rawJson)
        
        content = json["content"].stringValue
        date = json["date"].stringValue
        seq_no = json["seq_no"].intVale
    }
}
