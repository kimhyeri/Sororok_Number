//
//  ContactsViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 18..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var cellView: UIImageView!
    @IBOutlet weak var cellSelected: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var saveLabel: UILabel!
    
    var checkState = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    
        tableView.register(UINib(nibName:"DetailHomeTableViewCell",bundle: nil), forCellReuseIdentifier: "DetailHomeTableViewCell")
        tableView.register(UINib(nibName:"NotSearchTableViewCell",bundle: nil), forCellReuseIdentifier: "NotSearchTableViewCell")

        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "btnCommListSetWh"), style: .done, target: self, action: #selector(ContactsViewController.pressedButton))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        if section == 0 {
            label.text = " ㄱ"
            label.backgroundColor = UIColor.white
        }else{
            label.text = " ㄴ"
            label.backgroundColor = UIColor.lightGray
        }
        return label
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //데이터 없을때
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "NotSearchTableViewCell", for: indexPath) as! NotSearchTableViewCell
        //return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHomeTableViewCell", for: indexPath) as! DetailHomeTableViewCell
        cell.userImage?.layer.cornerRadius = (cell.userImage?.frame.width)!/2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeView(alpha: true)
        updateCount()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        updateCount()
        if tableView.indexPathsForSelectedRows?.count == nil{
            changeView(alpha: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    @objc func pressedButton(){
        let storyboard = UIStoryboard.init(name: "ManagerGroup", bundle: nil)
        let uv = storyboard.instantiateViewController(withIdentifier: "ManagerGroup") as! ManagerGroupViewController
        self.navigationController?.pushViewController(uv, animated: true)
    }
    
    @IBAction func allButtonPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            sender.setImage(UIImage(named: "icnListCheckOn"), for: .normal)
            sender.setImage(UIImage(named: "icnListCheckOff"), for: .selected)
        }
        if checkState == false {
            checkState = true
            for section in 0..<tableView.numberOfSections {
                for row in 0..<tableView.numberOfRows(inSection: section) {
                    tableView.selectRow(at: IndexPath(row: row, section: section), animated: false, scrollPosition: .none)
                }
            }
            updateCount()
            changeView(alpha: true)
        }else{
            checkState = false
            changeView(alpha: false)
            for section in 0..<tableView.numberOfSections {
                for row in 0..<tableView.numberOfRows(inSection: section) {
                    tableView.deselectRow(at: IndexPath(row: row, section: section), animated: false)
                }
            }
        }
    }
}


//MARK: update selected cell
extension ContactsViewController {
    
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
