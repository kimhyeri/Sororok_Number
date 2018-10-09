//
//  TwoViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 17..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TwoViewController: UIViewController {
    
    @IBOutlet weak var firstDescLabel: UILabel!
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var firstLoginView: UIView!
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
    var searchText : String?
    var groupDefaultImages = ["imgDefaultGroup01","imgDefaultGroup02","imgDefaultGroup03","imgDefaultGroup04","imgDefaultGroup05","imgDefaultGroup06"]
    var repoList : repoListSet?
    var searchList : repoListSet?
    var result = [Any]()
    
    let search = Notification.Name(rawValue: searchNotificationKey)
    let searchDone = Notification.Name(rawValue: searchDoneNotificationKey)
    let reloadTable = Notification.Name(rawValue: reloadTalbeViewKey)
    let changeName = Notification.Name(rawValue: nameChangedKey)
    
    override func viewWillAppear(_ animated: Bool) {
        loadItem(memberId: UserDefaults.standard.integer(forKey: "memberId"))
        if let image = UserDefaults.standard.string(forKey: "imageName") {
            if let url = URL(string: APICollection.sharedAPI.imageUrl + image) {
                imageButton.imageView?.kf.setImage(with: url)
            }
        } else {
            imageButton.setImage(UIImage(named: "girlBig"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObserver()
        initNavigation()
        defaultView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.searchNoti(_:)), name: search, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.searchDoneNoti), name: searchDone, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTableNoti), name: reloadTable , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.changedName), name: changeName, object: nil)
    }
    
    @objc func reloadTableNoti(){
        loadItem(memberId: UserDefaults.standard.integer(forKey: "memberId"))
    }
    
    @objc func searchDoneNoti(){
        firstLoginView.alpha = 0
        loadItem(memberId: UserDefaults.standard.integer(forKey: "memberId"))
    }
    
    @objc func searchNoti(_ notification: Notification){

        if let data = notification.userInfo as? [String: String]{
            for (_, text) in data {
                searchText = text
            }
        }
        
        guard searchText != nil else{return}
        
        let parameter : Parameters = [
            "memberId" : UserDefaults.standard.integer(forKey: "memberId"),
            "name" : searchText!
        ]

        Alamofire.request("http://45.63.120.140:40005/repository/search", method: .get, parameters: parameter).responseJSON { response in
            let json = JSON(response.result.value)
            print(json)
            switch response.result {
            case .success:
                print("search success")
                self.repoList = repoListSet(rawJson: json)
                if self.repoList?.dataList.count == 0 {
                    self.firstTitleLabel.text = "해당하는 그룹이 없네요."
                    self.firstDescLabel.text = "그룹명을 다시 확인해주세요!"
                    self.firstLoginView.alpha = 1
                }else{
                    self.firstLoginView.alpha = 0
                }
                self.view.endEditing(true)
                self.tableView.reloadData()
                break
            case .failure:
                print("fail")
                break
            }
        }
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

extension TwoViewController {
    func initNavigation(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        UIApplication.shared.statusBarStyle = .default
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
                if self.repoList?.dataList.count == 0 {
                    self.firstLoginView.alpha = 1
                }
                self.tableView.reloadData()
                break
            case .failure:
                print("fail")
                break
            }
        }
    }
}

//MARK: ScrollViewDeleate animation 잠시 막아놈

//extension TwoViewController : UIScrollViewDelegate {
//    func changeView(){
//        if movedView == false{
//            searchView.frame = CGRect(x: 0, y: self.firstView.frame.height , width: self.view.frame.width, height: 38)
//            tableView.frame = CGRect(x: 0, y: self.firstView.frame.height + self.searchView.frame.height, width: self.view.frame.width, height: self.view.frame.height - (firstView.frame.height + searchView.frame.height))
//        }
//    }
//
//    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
//        self.lastContentOffset = scrollView.contentOffset.y
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        scrollView.decelerationRate = UIScrollViewDecelerationRateFast
//        let y = 227 - scrollView.contentOffset.y
//        let h = max(65, y)
//        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: h)
//        firstView.frame = rect
//
//        let x = 65 + -scrollView.contentOffset.y
//        let a = min(x, 90)
//        let rect1 = CGRect(x: 10, y: a, width: 355, height: 146)
//        insideView.frame = rect1
//
//        changeView()
//        if (h < 130) {
//            let rect2 = CGRect(x: 0, y: 65 - h , width: view.bounds.width, height: 65)
//            topView.frame = rect2
//        }
//
//        if (self.lastContentOffset < scrollView.contentOffset.y) {
//            insideView.alpha = 1 - ( tableView.contentOffset.y * 0.01)
//        }
//    }
//}
