//
//  SettingView.swift
//  Number
//
//  Created by hyerikim on 08/10/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import Foundation
import UIKit
import StoreKit
import MessageUI

//MARK: default view
extension SettingViewController {
    func defaultView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let height = 20 + (self.navigationController?.navigationBar.frame.height)!
        
        naviView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: height)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
}

//MARK: manage tableview
extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell\(indexPath.row+1)", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let myPage = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "MyPage") as! MyPageViewController
            self.navigationController?.pushViewController(myPage, animated: true)
            
        case 1:
            let popUp = UIStoryboard(name: "Delete", bundle: nil).instantiateViewController(withIdentifier: "popUp") as! DeleteViewController
            popUp.modalPresentationStyle = .overCurrentContext
            self.present(popUp, animated: false, completion: nil)
        case 2:
            let popUp = UIStoryboard(name: "Logout", bundle: nil).instantiateViewController(withIdentifier: "Logout") as! LogoutViewController
            popUp.modalPresentationStyle = .overCurrentContext
            self.present(popUp, animated: false, completion: nil)
        case 3:
            SKStoreReviewController.requestReview()
        case 4:
            print("개발자에게 문의")
            let message : MFMailComposeViewController = MFMailComposeViewController()
            message.mailComposeDelegate = self
            message.setToRecipients(["hyer1k@naver.com"])
            message.setSubject("소로록 문의")
            self.present(message, animated: true, completion: nil)
        default:
            return
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

//MARK: sending email
extension SettingViewController : MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}

