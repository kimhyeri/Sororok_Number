//
//  DetailHomeTableViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 24..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class DetailHomeTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName:"DetailHomeTableViewCell",bundle: nil), forCellReuseIdentifier: "DetailHomeTableViewCell")
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "header"
        label.backgroundColor = UIColor.lightGray
        return label
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHomeTableViewCell", for: indexPath) as! DetailHomeTableViewCell
        return cell
    }
    
}
