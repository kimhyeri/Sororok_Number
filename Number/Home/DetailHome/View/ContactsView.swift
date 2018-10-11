//
//  ContactsView.swift
//  Number
//
//  Created by hyerikim on 08/10/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import Foundation
import Kingfisher

//MARK: default view
extension ContactsViewController {
    
    func defaultView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        titleLabel.text = ContactsViewController.repoName
        titleLabel.sizeToFit()
        
        tableView.register(UINib(nibName:"DetailHomeTableViewCell",bundle: nil), forCellReuseIdentifier: "DetailHomeTableViewCell")
        tableView.register(UINib(nibName:"NotSearchTableViewCell",bundle: nil), forCellReuseIdentifier: "NotSearchTableViewCell")
        
        titleView.frame = CGRect(x: titleView.frame.origin.x, y: titleView.frame.origin.y , width: titleLabel.frame.width + 6 , height: titleView.frame.height )
        
        let backButton = UIBarButtonItem(image: UIImage(named: "btnCommBackWh"), style: .plain, target: self, action: #selector(ContactsViewController.backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.imageInsets.left = -10
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "btnCommListSetWh"), style: .done, target: self, action: #selector(ContactsViewController.pressedButton))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    func updateCount(){
        if let list = tableView.indexPathsForSelectedRows {
            saveLabel.text = "\(list.count)"
        }
    }
    
    func changeView(alpha: Bool){
        if(alpha == true){
            cellView.alpha = 1
            saveLabel.alpha = 1
            cellSelected.alpha = 0.5
        }else {
            cellView.alpha = 0
            saveLabel.alpha = 0
            cellSelected.alpha = 0
        }
    }
    
}
