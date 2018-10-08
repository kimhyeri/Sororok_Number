//
//  AdminGroupViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 21..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class AdminGroupViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var cellSelected: UIButton!
    @IBOutlet weak var savedLabel: UILabel!
    @IBOutlet weak var cellView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        defautlView()
    }

    @objc func saveButton(){
        print("saved")
    }
    
    @IBAction func outButtonPressed(_ sender: Any) {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}

