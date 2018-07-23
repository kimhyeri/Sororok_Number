//
//  Timer.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 23..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import Foundation

//MARK: Timer 3 min
extension LoginViewController {
    
    //인증번호를 눌렀을 때 입력시간이 3분에서 0분까지 줄어들게
    func timeLimitStart() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LoginViewController.timeLimit), userInfo: nil, repeats: true)
    }
    
    //1초마다 라벨에 표시하기
    @objc func timeLimit() {
        if time > 0 {
            time -= 1
            timeDown.text = "입력시간 \(time/60)분\(time%60)초"
        }else{
            timeLimitStop()
        }
    }
    
    func timeLimitStop() {
        startTimer = false
        timer.invalidate()
    }
}
