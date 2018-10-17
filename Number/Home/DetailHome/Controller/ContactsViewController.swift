//
//  ContactsViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 18..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import Contacts
import Alamofire
import SwiftyJSON

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var selectAllbutton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var cellView: UIImageView!
    @IBOutlet weak var cellSelected: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var nothingView: UIView!
    
    var matchData : [Int:[DetailMember]] = [Int:[DetailMember]]()
    var searchText : String?
    var sorted = [DetailMember]()
    var final = [Any]()
    var checkState = false
    var index = DefualtIndex()
    var memberList : DetailMemberSet?
    var selected = [String:String]()
    let contact = CNMutableContact()
    
    static var repoId : Int?
    static var repoName : String?
    
    let searchMember = Notification.Name(rawValue: searchMemberNotificationKey)
    let searchMemberDone = Notification.Name(rawValue: searchMemberDoneNotificationKey)
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultView()
        createObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func sortName(count: Int){
        sorted = (memberList?.memberList.sorted(by: { $1.name > $0.name }))!
    }
    
    func loadData() {
        let parameter = [
        "repositoryId" : ContactsViewController.repoId
        ]
    
        APICollection.sharedAPI.getRepoMember(parameter: parameter) { (result) -> (Void) in
            self.memberList = DetailMemberSet(rawJson: result)
            self.titleLabel.text = ContactsViewController.repoName
    
            if let count = self.memberList?.memberList.count {
                self.totalLabel.text = "총 \(count)명"
                self.sortName(count: count)
            }
    
            self.tableView.reloadData()
        }
    }
    
    //뒤로가기 버튼
    @objc func backButtonPressed() {
        let storyboard = UIStoryboard.init(name: "CodeNum", bundle: nil)
        let bv = storyboard.instantiateViewController(withIdentifier: "ST") as! CustomNaviViewController
        self.present(bv, animated: true, completion: nil)
    }
    
    //그룹 관리 버튼
    @objc func pressedButton(){
        let storyboard = UIStoryboard.init(name: "ManagerGroup", bundle: nil)
        let uv = storyboard.instantiateViewController(withIdentifier: "ManagerGroup") as! ManagerGroupViewController
        self.navigationController?.pushViewController(uv, animated: true)
    }
    
    //터치 끝내기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    //전체 선택 버튼
    @IBAction func allButtonPressed(_ sender: UIButton) {
        
        if checkState == false {
            checkState = true
            selectButton.setImage(UIImage(named: "icnListCheckOn"), for: .normal)
            
            for section in 0..<tableView.numberOfSections {
                for row in 0..<tableView.numberOfRows(inSection: section) {
                    tableView.selectRow(at: IndexPath(row: row, section: section), animated: false, scrollPosition: .none)
                    self.selected.updateValue(matchData[section]![row].name, forKey: (matchData[section]![row].phone))
                }
            }
            updateCount()
            changeView(alpha: true)
        }else{
            selectButton.setImage(UIImage(named:"icnListCheckOff"), for: .normal)
            checkState = false
            changeView(alpha: false)
            for section in 0..<tableView.numberOfSections {
                for row in 0..<tableView.numberOfRows(inSection: section) {
                    tableView.deselectRow(at: IndexPath(row: row, section: section), animated: false)
                    self.selected.removeValue(forKey: (matchData[section]![row].phone))

                }
            }
        }
    }
    
    //전화번호 저장 버튼
    @IBAction func saveButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Progress", bundle: nil)
        let nv = storyboard.instantiateViewController(withIdentifier: "Progress") as! ProgressViewController
        self.present(nv, animated: true, completion: nil)
        let save = Notification.Name(rawValue: saveNotificationKey)
        NotificationCenter.default.post(name: save, object: nil, userInfo: self.selected)
    }
}
