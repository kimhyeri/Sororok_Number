//
//  ManagerGroupViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 21..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class ManagerGroupViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var changeCodeView: UIView!
    
    var manager :[String] = ["그룹 공유하기", "그룹원 관리", "관리자 변경", "그룹 폭파" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "btnCommBackBl")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "btnCommBackBl")
        
        self.navigationController?.navigationBar.topItem?.title = ""
        changeCodeView.clipsToBounds = true
        changeCodeView.layer.cornerRadius = 3
        changeCodeView.clipsToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func changeCodeButtonPressed(_ sender: Any) {
        codeLabel.text = "FQWQ14"
    }
}

extension ManagerGroupViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ManagerCellTableViewCell
        cell.label.text = manager[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let activity = UIActivityViewController(activityItems: ["그룹코드 : \(codeLabel.text!)"], applicationActivities: nil)
            activity.popoverPresentationController?.sourceView = self.view
            self.present(activity, animated: true, completion: nil)
        }
            
        else if indexPath.row == 1 {
            let storyboard = UIStoryboard.init(name: "Manager", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ManageGroup")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 2 {
            let storyboard = UIStoryboard.init(name: "Manager", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ChangeManager")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 3 {
            let storyboard = UIStoryboard.init(name: "Manager", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Delete")
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: false, completion: nil)
        }
    }
}

