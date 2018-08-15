//
//  CodeNumViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import SideMenu

class CodeNumViewController: UIViewController {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameShadow: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var topView: UIView!
    
    var interactor = Interactor()
    let change = Notification.Name(rawValue: changeViewNotificationKey)
    let pull = Notification.Name(rawValue: changeBackViewNotificationKey)
    var navigationBarHeight: CGFloat = 20
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func pressedSosik(_ sender: Any) {
        let nv = self.storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController")
        present(nv!, animated: true, completion: nil)
    }
    
    @IBAction func profilePressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyPage") as! MyPageViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.alpha = 0
        navigationBarHeight = navigationBarHeight + (self.navigationController?.navigationBar.frame.height)!
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        imageView.backgroundColor = .black
        addButton()
        createObserver()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func addButton() {
        let groupCreate = UIButton()
        groupCreate.backgroundColor = .black
        groupCreate.frame = CGRect(x: view.frame.width - 80, y: view.frame.height - 80, width: 50, height: 50)
        self.view.addSubview(groupCreate)
        groupCreate.addTarget(self, action: #selector(self.createGroup), for: UIControlEvents.touchUpInside)
    }
    
    @objc func createGroup(){
        let storyboard = UIStoryboard(name: "GroupCreate", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GroupCreate") as! GroupCreateViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func createObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(CodeNumViewController.updateView(notification:)), name: change, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CodeNumViewController.updateBackView(notification:)), name: pull, object: nil)
    }
    
    @objc func updateView(notification: NSNotification) {
        print("댕김댕김")
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        firstView.frame = CGRect(x:0, y: 0, width: self.view.frame.width , height: navigationBarHeight )
        searchView.frame = CGRect(x: 0, y: self.firstView.frame.height , width: self.view.frame.width, height: 38)
        thirdView.frame = CGRect(x: 0, y: self.firstView.frame.height + self.searchView.frame.height, width: self.view.frame.width, height: self.view.frame.height - (searchView.frame.height))
        imageView.alpha = 0
        nameLabel.alpha = 0
        nameShadow.alpha = 0
        topView.alpha = 1

        self.view.layoutIfNeeded()

    }
    
    @objc func updateBackView(notification: NSNotification) {
        print("댕김댕김")
        self.view.layoutIfNeeded()
    }
}


