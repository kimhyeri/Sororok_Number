//
//  SettingViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 21..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import StoreKit

class SettingViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var naviView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        tableView.delegate = self
        tableView.dataSource = self
        initNav()
        let height = 20 + (self.navigationController?.navigationBar.frame.height)!
        naviView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: height)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell\(indexPath.row+1)", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
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

//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Review") as! ReviewViewController
//            self.present(vc, animated: true, completion: nil)
        case 4:
            print("개발자에게 문의")
        default:
            return
        }

    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}

