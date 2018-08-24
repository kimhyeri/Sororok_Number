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
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var imageSecondView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nothingLabel1: UILabel!
    @IBOutlet weak var nothingLabel2: UILabel!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameShadow: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var topView: UIView!
    
    var lastContentOffset: CGFloat = 0
    var navigationBarHeight: CGFloat = 20
    var movedView = false
    var tableSize : CGFloat = 0
    var defaultSize : [CGRect] = []
    
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
        initNavigation()
        tableView.delegate = self
        tableView.dataSource = self
        defaultView()
    }
    
    func defaultView(){
        defaultSize.append(imageButton.frame)
        defaultSize.append(nameLabel.frame)
        defaultSize.append(nameShadow.frame)
        
        self.navigationController!.navigationBar.topItem!.title = ""
        floatingView.layer.cornerRadius = floatingView.frame.width/2
        //        topView.frame = CGRect(x: 0, y: -65 , width: self.view.frame.width, height: 65)
        //        tableSize = tableView.frame.height
        navigationBarHeight = navigationBarHeight + (self.navigationController?.navigationBar.frame.height)!
        imageSecondView.layer.cornerRadius = self.imageSecondView.frame.size.width / 2
        nothingLabel1.alpha = 0
        nothingLabel2.alpha = 0
        
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
        if movedView == false{
            searchView.frame = CGRect(x: 0, y: self.firstView.frame.height , width: self.view.frame.width, height: 38)
            tableView.frame = CGRect(x: 0, y: self.firstView.frame.height + self.searchView.frame.height, width: self.view.frame.width, height: self.view.frame.height - (firstView.frame.height + searchView.frame.height))
            
            //            imageButton.frame = CGRect(x:self.imageButton.frame.minX, y: self.imageButton.frame.minY - 3 , width: self.imageButton.frame.width , height: imageButton.frame.height )
            //            nameLabel.frame = CGRect(x:self.nameLabel.frame.minX, y: self.nameLabel.frame.minY  - 3, width: self.nameLabel.frame.width , height: nameLabel.frame.height )
            //            nameShadow.frame = CGRect(x:self.nameShadow.frame.minX, y: self.nameShadow.frame.minY  - 3, width: self.nameShadow.frame.width , height: nameShadow.frame.height )
            print(imageButton.frame)
            print(firstView.frame)
            
            topView.alpha = topView.alpha + (tableView.contentOffset.y * 0.001)
            imageButton.alpha = imageButton.alpha - (tableView.contentOffset.y * 0.001)
            nameLabel.alpha = nameLabel.alpha - (tableView.contentOffset.y * 0.001)
            nameShadow.alpha = nameLabel.alpha - (tableView.contentOffset.y * 0.001)
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.decelerationRate = UIScrollViewDecelerationRateFast
        let y = 227 - scrollView.contentOffset.y
        let h = max(65, y)
        print(h)
        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: h)
        firstView.frame = rect
        
        changeView()
        
        if h < 130 {
            let rect2 = CGRect(x: 0, y: 65 - h , width: view.bounds.width, height: 65)
            topView.frame = rect2
        }
        
        if h == 227 {
            imageButton.frame = defaultSize[0]
            nameLabel.frame = defaultSize[1]
            nameShadow.frame = defaultSize[2]
            imageButton.alpha = 1
            nameLabel.alpha = 1
            nameShadow.alpha = 1
        }
        
    }
}

//MARK: TableView Delegate, DataSource

extension TwoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
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
            let nv = storyboard.instantiateViewController(withIdentifier: "NV") as! ContactNaviViewController
            self.present(nv, animated: true, completion: nil)
            //            self.navigationController?.pushViewController(nv, animated: true)
        }
        
        alert.addAction(noAlert)
        alert.addAction(okAlert)
        present(alert,animated: true, completion: nil)
    }
}

extension TwoViewController {
    func initNavigation(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        UIApplication.shared.statusBarStyle = .default
        
        //        let myPageImage = UIImage(named: "mypage")?.withRenderingMode(.alwaysOriginal)
        //        let rightBarButtonItem = UIBarButtonItem(image: myPageImage, style: .plain, target: self, action: nil)
        //        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        //
        //        let categoryImage = UIImage(named: "categoryButton")?.withRenderingMode(.alwaysOriginal)
        //        let leftBarButtonItem = UIBarButtonItem(image: categoryImage, style: .plain, target: self, action: nil)
        //        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
    }
}





