//
//  ManagerGroupView.swift
//  Number
//
//  Created by hyerikim on 08/10/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import Foundation

//MARK: manage default view
extension ManagerGroupViewController {
    
    func defualtView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "btnCommBackBl")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "btnCommBackBl")
        self.navigationController?.navigationBar.topItem?.title = ""
        
        changeCodeView.clipsToBounds = true
        changeCodeView.layer.cornerRadius = 3
        
        if UserDefaults.standard.integer(forKey: "authority") == 0 {
            refreshButton.alpha = 0
            refreshButton.isEnabled = false
        }

    }
    
    func presentDeletePopup(){
        let storyboard = UIStoryboard.init(name: "Manager", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Delete")
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
}

//MARK: manage tableview
extension ManagerGroupViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch UserDefaults.standard.integer(forKey: "authority") {
        case 0:
            return member.count
        default:
            return manager.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ManagerCellTableViewCell
        switch UserDefaults.standard.integer(forKey: "authority") {
        case 0:
            cell.label.text = member[indexPath.row]
        default:
            cell.label.text = manager[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let activity = UIActivityViewController(activityItems: ["그룹명 : \(ContactsViewController.repoName!)","그룹코드 : \(codeLabel.text!)"], applicationActivities: nil)
            activity.popoverPresentationController?.sourceView = self.view
            self.present(activity, animated: true, completion: nil)
        }
            
        else if indexPath.row == 1 {
            switch UserDefaults.standard.integer(forKey: "authority") {
            case 0:
                presentDeletePopup()
            default:
                presentDeletePopup()
            }
        }
            //그룹원 강퇴 기능
         else if indexPath.row == 2 {
             let storyboard = UIStoryboard.init(name: "Manager", bundle: nil)
             let vc = storyboard.instantiateViewController(withIdentifier: "ManageGroup")
             self.navigationController?.pushViewController(vc, animated: true)
         }
        
            //관리자 변경 기능
         else if indexPath.row == 3 {
             let storyboard = UIStoryboard.init(name: "Manager", bundle: nil)
             let vc = storyboard.instantiateViewController(withIdentifier: "ChangeManager")
             self.navigationController?.pushViewController(vc, animated: true)
         }


    }
}
