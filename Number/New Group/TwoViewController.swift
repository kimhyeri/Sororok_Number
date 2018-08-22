//
//  TwoViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 17..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import SideMenu

class TwoViewController: UIViewController {
    
    @IBOutlet weak var floatingView: UIView!
    @IBOutlet weak var imageSecondView: UIImageView!
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
    var navigationBarHeight: CGFloat = 20
    var movedView = false
    
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
        tableView.delegate = self
        tableView.dataSource = self
        defaultView()
    }
    
    func defaultView(){
        self.navigationController!.navigationBar.topItem!.title = ""
        floatingView.layer.cornerRadius = floatingView.frame.width/2
        topView.frame = CGRect(x: 0, y: -100 , width: self.view.frame.width, height: navigationBarHeight)
        navigationBarHeight = navigationBarHeight + (self.navigationController?.navigationBar.frame.height)!
        imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        imageSecondView.layer.cornerRadius = self.imageSecondView.frame.size.width / 2
        nothingLabel1.alpha = 0
        nothingLabel2.alpha = 0
        topView.alpha = 0
        imageView.backgroundColor = .black
        
        tableView.register(UINib(nibName:"HomeTableViewCell",bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.register(UINib(nibName:"NothingTableViewCell",bundle: nil), forCellReuseIdentifier: "NothingTableViewCell")
        
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    @objc func buttonPressed(){
        let vc = UIViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func createGroupButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "GroupCreate", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GroupCreate") as! GroupCreateViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: ScrollViewDeleate animation

extension TwoViewController : UIScrollViewDelegate {
    func changeView(){
//        print("뷰 바뀐다")
        if movedView == false{
            if firstView.frame.height > navigationBarHeight{
                firstView.frame = CGRect(x:0, y: 0, width: self.view.frame.width , height: (firstView.frame.height - (tableView.contentOffset.y * 0.1)) )
                searchView.frame = CGRect(x: 0, y: self.firstView.frame.height , width: self.view.frame.width, height: 38)
                tableView.frame = CGRect(x: 0, y: self.firstView.frame.height + self.searchView.frame.height, width: self.view.frame.width, height: self.view.frame.height - (firstView.frame.height + searchView.frame.height))
                imageView.frame = CGRect(x:self.imageView.frame.minX, y: self.imageView.frame.minY - 5, width: self.imageView.frame.width , height: imageView.frame.height )
                nameLabel.frame = CGRect(x:self.nameLabel.frame.minX, y: self.nameLabel.frame.minY  - 5, width: self.nameLabel.frame.width , height: nameLabel.frame.height )
                nameShadow.frame = CGRect(x:self.nameShadow.frame.minX, y: self.nameShadow.frame.minY  - 5, width: self.nameShadow.frame.width , height: nameShadow.frame.height )
                
                if topViewCon.constant < -300 {
                    topViewCon.constant = topViewCon.constant + 2
                }
                topView.alpha = topView.alpha + (tableView.contentOffset.y * 0.1)
                imageView.alpha = imageView.alpha - (tableView.contentOffset.y * 0.001)
                nameLabel.alpha = imageView.alpha - (tableView.contentOffset.y * 0.001)
                nameShadow.alpha = imageView.alpha - (tableView.contentOffset.y * 0.001)
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func changeBackView(){
        if movedView == true {
            if firstView.frame.height > navigationBarHeight{
//                print("원점회복")
                firstView.frame = CGRect(x:0, y: 0, width: self.view.frame.width , height: (firstView.frame.height + (tableView.contentOffset.y * 0.1)) )
                searchView.frame = CGRect(x: 0, y: self.firstView.frame.height , width: self.view.frame.width, height: 38)
                tableView.frame = CGRect(x: 0, y: self.firstView.frame.height + self.searchView.frame.height, width: self.view.frame.width, height: self.view.frame.height + (firstView.frame.height + searchView.frame.height))
                imageView.frame = CGRect(x:self.imageView.frame.minX, y: self.imageView.frame.minY + 5, width: self.imageView.frame.width , height: imageView.frame.height )
                nameLabel.frame = CGRect(x:self.nameLabel.frame.minX, y: self.nameLabel.frame.minY  + 5, width: self.nameLabel.frame.width , height: nameLabel.frame.height )
                nameShadow.frame = CGRect(x:self.nameShadow.frame.minX, y: self.nameShadow.frame.minY  + 5, width: self.nameShadow.frame.width , height: nameShadow.frame.height )
                
                if topViewCon.constant > -300 {
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
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= navigationBarHeight {
            changeView()
            print("뷰 줄어든다")
            
        } else if scrollView.contentOffset.y > navigationBarHeight {
            print("원상복귀")
//            heightConstraint.constant = collectionViewHeight
//            tableView.isScrollEnabled = true
        }
        
//        if (self.lastContentOffset < scrollView.contentOffset.y) {
//            changeView()
//        } else if (self.lastContentOffset > scrollView.contentOffset.y) {
//            changeBackView()
//        }
    }
}

//MARK: TableView Delegate, DataSource

extension TwoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
//        데이터 아무것도 없을 경우
//        let cell = tableView.dequeueReusableCell(withIdentifier: "NothingTableViewCell", for: indexPath)
//        return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.cellView.layer.cornerRadius = 10
        cell.cellView.layer.borderWidth = 1
        cell.cellView.layer.borderColor = UIColor(red:196/255, green:197/255, blue:214/255, alpha: 1).cgColor
        cell.groupImage.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        //데이터가 있을 경우만 활성화 시킴
        createAlert()
    }
    
}

//MARK: AlertViewController Custom

extension TwoViewController {
    func createAlert(){
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
            let nv = storyboard.instantiateViewController(withIdentifier: "DetailHome") as! ContactsViewController
            nv.viewWillAppear(true)
            self.navigationController?.pushViewController(nv, animated: true)
        }
        
        alert.addAction(noAlert)
        alert.addAction(okAlert)
        present(alert,animated: true, completion: nil)
    }
}





