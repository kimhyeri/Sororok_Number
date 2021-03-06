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
        let json = JSON(rawJson)
        
        content = json["content"].stringValue
        date = json["date"].stringValue
        seq_no = json["seq_no"].intValue
    }
}

struct HistoryDataSet {
    lazy var historyList = Array<HistoryData>()
    init(rawJson: Any) {
        let json = JSON(rawJson)
        for data in json.arrayValue {
            historyList.append(HistoryData(rawJson: data))
        }
    }
}
