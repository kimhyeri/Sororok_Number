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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName:"DetailHomeTableViewCell",bundle: nil), forCellReuseIdentifier: "DetailHomeTableViewCell")
        
        let saveButton = UIBarButtonItem(title: "저장",  style: .plain, target: self, action: #selector(self.saveButton))
        self.navigationController?.navigationBar.tintColor = UIColor.init(hex: "343ACF")
        self.navigationItem.rightBarButtonItem = saveButton
        
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
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

//MARK: tableView
extension AdminGroupViewController {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHomeTableViewCell", for: indexPath) as! DetailHomeTableViewCell
        cell.userImage?.layer.cornerRadius = (cell.userImage?.frame.width)!/2
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
}

extension AdminGroupViewController {
    
    func updateCount(){
        if let list = tableView.indexPathsForSelectedRows {
            savedLabel.text = "\(list.count)"
        }
    }
    
    func changeView(alpha: Bool){
        if(alpha == true){
            cellView.alpha = 1
            savedLabel.alpha = 1
            cellSelected.alpha = 0.5
        }else {
            cellView.alpha = 0
            savedLabel.alpha = 0
            cellSelected.alpha = 0
        }
    }
}
