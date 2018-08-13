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
    @IBOutlet weak var heightConstant: NSLayoutConstraint!
    
    var interactor = Interactor()
    let change = Notification.Name(rawValue: changeViewNotificationKey)
    
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
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
        self.view.addGestureRecognizer(panGesture)
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
    }
    
    @objc func updateView(notification: NSNotification) {
        heightConstant.constant = 100
        nameLabel.text = "희은님"
        imageView.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        firstView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
    }
}

//MARK: Gesture Delegate
extension CodeNumViewController: UIGestureRecognizerDelegate {
    @objc func handlePanGesture(_ sender: UIScreenEdgePanGestureRecognizer){
        let location = sender.translation(in: view)
        let progress = -(location.y / self.view.frame.height)
        print(location)
        print(progress)
        switch sender.state {
        case .changed:
            print("changed")
        default:
            print("default")
        }
    }
}

