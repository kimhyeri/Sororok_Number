//
//  MyPageView.swift
//  Number
//
//  Created by hyerikim on 08/10/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import Foundation

extension MyPageViewController {
    
    func defaultView(){
        
        self.title = "마이페이지"
        defaultFrame = textView.frame

        nameText.delegate = self
        numText.delegate = self
        emailText.delegate = self
        
        numText.text = UserDefaults.standard.string(forKey: "phone")
        emailText.text = UserDefaults.standard.string(forKey: "email")
        nameText.text = UserDefaults.standard.string(forKey: "name")

        if let image = UserDefaults.standard.string(forKey: "imageName") {
            print(image)
            if image == " " {
                myImage.image = UIImage(named: "girlBig")
            } else {
                let url = URL(string: APICollection.sharedAPI.imageUrl + image)
                myImage.kf.setImage(with: url)
            }
        } else {
            myImage.image = UIImage(named: "girlBig")
        }
        
        myImage.layer.cornerRadius = myImage.frame.width/2
        
        nameText.attributedPlaceholder = NSAttributedString(string: "이름", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        emailText.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        numText.attributedPlaceholder = NSAttributedString(string: "전화번호", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        setNaviButton()
    }
    
    func setNaviButton() {
        let saveButton = UIBarButtonItem(title: "저장",  style: .plain, target: self, action: #selector(self.saveButton))
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
}
