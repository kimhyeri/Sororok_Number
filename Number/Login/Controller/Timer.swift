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
    
    func timeLimitStart() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LoginViewController.timeLimit), userInfo: nil, repeats: true)
    }
    
    func timeLimitStop() {
        startTimer = false
        print(timer.isValid)
        timer.invalidate()
    }
    
    @objc func timeLimit() {
        if time > 0 {
            time -= 1
            timeDown.text = "입력시간 \(time/60)분\(time%60)초"
        }else{
            timeLimitStop()
        }
    }
}
