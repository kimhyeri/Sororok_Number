//
//  LoginView.swift
//  Number
//
//  Created by hyerikim on 2018. 9. 18..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

extension LoginViewController {
    
    //네비게이션 설정 해야함 사용자 정보 받기 성공했을 경우
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "")
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        let backButton = UIBarButtonItem(image: UIImage(named: "btnCommBackWh"), style: .plain, target: self, action: #selector(back))
        navItem.leftBarButtonItem = backButton
        backButton.imageInsets.left = -10
        
        let doneItem = UIBarButtonItem.init(title: "확인", style: .plain, target: nil, action: #selector(done))
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        navBar.tintColor = UIColor.white
        self.view.addSubview(navBar)
    }
    
}
