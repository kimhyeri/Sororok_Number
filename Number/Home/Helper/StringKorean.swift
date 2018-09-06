//
//  StringKorean.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 27..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import Foundation

extension String {
    func getHangul(num : Int) -> String {
        let hangle = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]

        return hangle[num]
    }
}
