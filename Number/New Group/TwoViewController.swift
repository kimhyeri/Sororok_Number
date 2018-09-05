//
//  TwoViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 17..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import SwiftyJSON

class TwoViewController: UIViewController {
    
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var floatingView: UIView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var imageSecondView: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nothingLabel1: UILabel!
    @IBOutlet weak var nothingLabel2: UILabel!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var topNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameShadow: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var topView: UIView!
    
    var lastContentOffset: CGFloat = 0
    var navigationBarHeight: CGFloat = 20
    var movedView = false
    var tableSize : CGFloat = 0
    var defaultSize : [CGRect] = []
    var defaultButton = 0
    var defaultLabel = 0
    var groupDefaultImages = ["imgDefaultGroup01","imgDefaultGroup02","imgDefaultGroup03","imgDefaultGroup04","imgDefaultGroup05","imgDefaultGroup06"]
    var repoList : repoListSet?
    
    @IBAction func pressedSosik(_ sender: Any) {
        makeDefault()
        let nv = self.storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController")
        present(nv!, animated: true, completion: nil)
    }
    
    @IBAction func profilePressed(_ sender: Any) {
        makeDefault()
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyPage") as! MyPageViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadItem(memberId: UserDefaults.standard.integer(forKey: "memberId"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigation()
        tableView.delegate = self
        tableView.dataSource = self
        defaultView()
    }
    
    func defaultView(){
        defaultSize.append(topView.frame)
        defaultSize.append(firstView.frame)
        defaultSize.append(insideView.frame)
        defaultSize.append(searchView.frame)
        defaultSize.append(tableView.frame)
        
        defaultButton = Int(self.imageButton.frame.origin.y)
        defaultLabel = Int(self.nameLabel.frame.origin.y)
        
        if let name = UserDefaults.standard.string(forKey: "name") {
            nameLabel.text = "\(name)님 \n 안녕하세요 !"
            topNameLabel.text = "\(name)님"
        }
        
        self.navigationController!.navigationBar.topItem!.title = ""
        floatingView.layer.cornerRadius = floatingView.frame.width/2
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
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.decelerationRate = UIScrollViewDecelerationRateFast
        let y = 227 - scrollView.contentOffset.y
        let h = max(65, y)
        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: h)
        firstView.frame = rect
        
        let x = 65 + -scrollView.contentOffset.y
        let a = min(x, 90)
        let rect1 = CGRect(x: 10, y: a, width: 355, height: 146)
        insideView.frame = rect1
        
        changeView()
        if (h < 130) {
            let rect2 = CGRect(x: 0, y: 65 - h , width: view.bounds.width, height: 65)
            topView.frame = rect2
        }
        
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            insideView.alpha = 1 - ( tableView.contentOffset.y * 0.01)
        }
    }
}

//MARK: TableView Delegate, DataSource

extension TwoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = repoList?.dataList.count {
            return count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if repoList?.dataList.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NothingTableViewCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
            cell.descLabel.text = repoList?.dataList[indexPath.row].extra_info
            cell.groupName.text = repoList?.dataList[indexPath.row].name
            let status = repoList?.dataList[indexPath.row].authority
            if status == 0 {
                cell.statusLabel.text = "멤버"
            }
            cell.groupImage?.image = UIImage(named: groupDefaultImages[indexPath.row % groupDefaultImages.count])
            cell.cellView.layer.cornerRadius = 10
            cell.cellView.layer.borderWidth = 1
            cell.cellView.layer.borderColor = UIColor(red:196/255, green:197/255, blue:214/255, alpha: 1).cgColor
            cell.groupImage.layer.cornerRadius = 10
            return cell
        }
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
    }
    
    func makeDefault() {
        topView.frame = defaultSize[0]
        firstView.frame = defaultSize[1]
        insideView.frame = defaultSize[2]
        searchView.frame = defaultSize[3]
        tableView.frame = defaultSize[4]
    }
    
    
    func loadItem(memberId: Int){
        let memberId : Parameters = [
            "memberId" : memberId
        ]
        
        Alamofire.request("http://45.63.120.140:40005/repository/list", method: .get, parameters: memberId).responseJSON {
            response in
            let json = JSON(response.result.value)
            print(json)
            switch response.result {
            case .success:
                print("success")
                self.repoList = repoListSet(rawJson: json)
                self.tableView.reloadData()
                break
            case .failure:
                print("fail")
                break
            }
        }
    }
}
