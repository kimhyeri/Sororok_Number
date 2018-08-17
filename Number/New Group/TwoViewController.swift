//
//  ViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 17..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

//
//  CodeNumViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import SideMenu

class TwoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nothingLabel1: UILabel!
    @IBOutlet weak var nothingLabel2: UILabel!
    @IBOutlet weak var topViewCon: NSLayoutConstraint!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameShadow: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var topView: UIView!
    
    var lastContentOffset: CGFloat = 0
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
        nothingLabel1.alpha = 0
        nothingLabel2.alpha = 0
        tableView.delegate = self
        tableView.dataSource = self
        topView.alpha = 0
        topView.frame = CGRect(x: 0, y: -100 , width: self.view.frame.width, height: navigationBarHeight)
        navigationBarHeight = navigationBarHeight + (self.navigationController?.navigationBar.frame.height)!
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        tableView.register(UINib(nibName:"HomeTableViewCell",bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        imageView.backgroundColor = .black
        addButton()
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
    
    @objc func updateView(notification: NSNotification) {
        print("댕김댕김")
        
        if let dyna = notification.userInfo?["scroll"] as? Double {
            print(dyna)
            
            let val = CGFloat(dyna)
        }
        
        if firstView.frame.height > navigationBarHeight{
            firstView.frame = CGRect(x:0, y: 0, width: self.view.frame.width , height: (firstView.frame.height - 2.2) )
            searchView.frame = CGRect(x: 0, y: self.firstView.frame.height , width: self.view.frame.width, height: 38)
            tableView.frame = CGRect(x: 0, y: self.firstView.frame.height + self.searchView.frame.height, width: self.view.frame.width, height: self.view.frame.height - (firstView.frame.height + searchView.frame.height))
            imageView.alpha = imageView.alpha - 0.02
            imageView.frame = CGRect(x:self.imageView.frame.minX, y: self.imageView.frame.minY - 5, width: self.imageView.frame.width , height: imageView.frame.height )
            nameLabel.frame = CGRect(x:self.nameLabel.frame.minX, y: self.nameLabel.frame.minY  - 5, width: self.nameLabel.frame.width , height: nameLabel.frame.height )
            nameShadow.frame = CGRect(x:self.nameShadow.frame.minX, y: self.nameShadow.frame.minY  - 5, width: self.nameShadow.frame.width , height: nameShadow.frame.height )
            nameLabel.alpha = imageView.alpha - 0.02
            nameShadow.alpha = imageView.alpha - 0.02
            topView.alpha = topView.alpha + 0.01
            if topViewCon.constant < -300 {
                topViewCon.constant = topViewCon.constant + 2
            }
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
        self.view.layoutIfNeeded()
        
    }
    
    @objc func updateBackView(notification: NSNotification) {
        print("댕김댕김")
        self.view.layoutIfNeeded()
        
        
    }
}




extension TwoViewController : UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.cellView.layer.cornerRadius = 10
        cell.cellView.layer.borderWidth = 1
        cell.cellView.layer.borderColor = UIColor(red:196/255, green:197/255, blue:214/255, alpha: 1).cgColor
        cell.groupImage.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        let alert = UIAlertController(title: "그룹 코드를 입력해주세요", message: nil, preferredStyle: .alert)
        alert.addTextField { (pTextField) in
            pTextField.placeholder = "코드 입력"
            pTextField.clearButtonMode = .whileEditing
            pTextField.borderStyle = .none
        }
        
        let noAlert = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default){
            (result: UIAlertAction) in
            alert.removeFromParentViewController()
        }
        let okAlert = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){
            (result: UIAlertAction) in
            alert.removeFromParentViewController()
            let storyboard = UIStoryboard.init(name: "DetailHome", bundle: nil)
            let nv = storyboard.instantiateViewController(withIdentifier: "DetailHome") as! DetailHomeTableViewController
            self.navigationController?.pushViewController(nv, animated: true)
        }
        
        alert.addAction(noAlert)
        alert.addAction(okAlert)
        present(alert,animated: true, completion: nil)
    }
    
    func changeView(){
        firstView.frame = CGRect(x:0, y: 0, width: self.view.frame.width , height: (firstView.frame.height - (tableView.contentOffset.y * 0.1)) )
        searchView.frame = CGRect(x: 0, y: self.firstView.frame.height , width: self.view.frame.width, height: 38)
        tableView.frame = CGRect(x: 0, y: self.firstView.frame.height + self.searchView.frame.height, width: self.view.frame.width, height: self.view.frame.height - (firstView.frame.height + searchView.frame.height))
        imageView.frame = CGRect(x:self.imageView.frame.minX, y: self.imageView.frame.minY - 5, width: self.imageView.frame.width , height: imageView.frame.height )
        nameLabel.frame = CGRect(x:self.nameLabel.frame.minX, y: self.nameLabel.frame.minY  - 5, width: self.nameLabel.frame.width , height: nameLabel.frame.height )
        nameShadow.frame = CGRect(x:self.nameShadow.frame.minX, y: self.nameShadow.frame.minY  - 5, width: self.nameShadow.frame.width , height: nameShadow.frame.height )

        if topViewCon.constant < -300 {
            topViewCon.constant = topViewCon.constant + 2
        }
        topView.alpha = topView.alpha + (tableView.contentOffset.y * 0.01)
        imageView.alpha = imageView.alpha - 0.02
        nameLabel.alpha = imageView.alpha - (tableView.contentOffset.y * 0.01)
        nameShadow.alpha = imageView.alpha - (tableView.contentOffset.y * 0.01)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    func changeBackView(){
        firstView.frame = CGRect(x:0, y: 0, width: self.view.frame.width , height: (firstView.frame.height + (tableView.contentOffset.y * 0.1)) )
        searchView.frame = CGRect(x: 0, y: self.firstView.frame.height , width: self.view.frame.width, height: 38)
        tableView.frame = CGRect(x: 0, y: self.firstView.frame.height + self.searchView.frame.height, width: self.view.frame.width, height: self.view.frame.height + (firstView.frame.height + searchView.frame.height))
        imageView.frame = CGRect(x:self.imageView.frame.minX, y: self.imageView.frame.minY + 5, width: self.imageView.frame.width , height: imageView.frame.height )
        nameLabel.frame = CGRect(x:self.nameLabel.frame.minX, y: self.nameLabel.frame.minY  + 5, width: self.nameLabel.frame.width , height: nameLabel.frame.height )
        nameShadow.frame = CGRect(x:self.nameShadow.frame.minX, y: self.nameShadow.frame.minY  + 5, width: self.nameShadow.frame.width , height: nameShadow.frame.height )
        
        if topViewCon.constant  -300 {
            topViewCon.constant = topViewCon.constant - 2
        }
        topView.alpha = topView.alpha + (tableView.contentOffset.y * 0.01)
        imageView.alpha = imageView.alpha - 0.02
        nameLabel.alpha = imageView.alpha - (tableView.contentOffset.y * 0.01)
        nameShadow.alpha = imageView.alpha - (tableView.contentOffset.y * 0.01)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }

func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (self.lastContentOffset < scrollView.contentOffset.y) {
        if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < 300 {
            if firstView.frame.height > navigationBarHeight{
                changeView()
            }
        }
    } else if (self.lastContentOffset > scrollView.contentOffset.y) {
        if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < 300 {
            if firstView.frame.height > navigationBarHeight{
                changeBackView()
            }
        }
    }
}

@objc func buttonPressed(){
    let vc = UIViewController()
    self.navigationController?.pushViewController(vc, animated: true)
}
}






