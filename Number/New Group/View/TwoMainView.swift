//
//  TwoMainView.swift
//  Number
//
//  Created by hyerikim on 2018. 9. 19..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

extension TwoViewController {
    @objc func changedName(){
        nameLabel.text = "\(UserDefaults.standard.string(forKey: "name")!)님 \n 안녕하세요 !"
    }
    
    func defaultView() {
        defaultButton = Int(self.imageButton.frame.origin.y)
        defaultLabel = Int(self.nameLabel.frame.origin.y)
        
        if let name = UserDefaults.standard.string(forKey: "name") {
            nameLabel.text = "\(name)님 \n 안녕하세요 !"
            topNameLabel.text = "\(name)님"
        }
        
        if let imageData =  UserDefaults.standard.data (forKey: "imageName") {
            if let image = UIImage(data: imageData) {
                imageButton.setImage(image, for: .normal)
                imageSecondView.setImage(image, for: .normal)
                imageButton.layer.cornerRadius = imageButton.frame.width/2
                imageSecondView.layer.cornerRadius = imageSecondView.frame.width/2
            }
        }
        
        self.navigationController!.navigationBar.topItem!.title = ""
        floatingView.layer.cornerRadius = floatingView.frame.width/2
        navigationBarHeight = navigationBarHeight + (self.navigationController?.navigationBar.frame.height)!
        imageSecondView.layer.cornerRadius = self.imageSecondView.frame.size.width / 2
        nothingLabel1.alpha = 0
        nothingLabel2.alpha = 0
    }
}
