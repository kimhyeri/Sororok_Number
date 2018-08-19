//
//  SettingTableViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 26..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit


class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell\(indexPath.row+1)", for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let popUp = UIStoryboard(name: "Delete", bundle: nil).instantiateViewController(withIdentifier: "popUp") as! DeleteViewController
        popUp.modalPresentationStyle = .overCurrentContext
        self.present(popUp, animated: false, completion: nil)
    }
}
