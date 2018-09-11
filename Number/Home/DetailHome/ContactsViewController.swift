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

extension Dictionary{
    mutating func changeKey(from: Key, to: Key){
        self[to] = self[from]
        self.removeValue(forKey: from)
    }
}

class ContactsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
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
    
    var searchText : String?
    var sortedName = NSMutableArray()
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
        titleLabel.text = ContactsViewController.repoName
        titleLabel.sizeToFit()
        
        let parameter = [
            "repositoryId" : ContactsViewController.repoId
        ]
        
        APICollection.sharedAPI.getRepoMember(parameter: parameter) { (result) -> (Void) in
            self.memberList = DetailMemberSet(rawJson: result)
            if let count = self.memberList?.memberList.count {
                self.totalLabel.text = "총 \(count)명"
                self.sortName(count: count)
            }
            self.tableView.reloadData()
        }
    }
    
    //문자열 정렬 먼저 필요함
    func sortName(count: Int){
        
        for i in 0..<count {
            sortedName.insert(memberList?.memberList[i].name, at: i)
        }
        sorted = (memberList?.memberList.sorted(by: { $1.name > $0.name }))!
        print(sorted)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"DetailHomeTableViewCell",bundle: nil), forCellReuseIdentifier: "DetailHomeTableViewCell")
        tableView.register(UINib(nibName:"NotSearchTableViewCell",bundle: nil), forCellReuseIdentifier: "NotSearchTableViewCell")
        defaultView()
        createObserver()
    }
    
    func defaultView(){
        titleView.frame = CGRect(x: titleView.frame.origin.x, y: titleView.frame.origin.y , width: titleLabel.frame.width + 6 , height: titleView.frame.height )
        
        let backButton = UIBarButtonItem(image: UIImage(named: "btnCommBackWh"), style: .plain, target: self, action: #selector(ContactsViewController.backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.imageInsets.left = -10
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "btnCommListSetWh"), style: .done, target: self, action: #selector(ContactsViewController.pressedButton))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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

//MARK: tableview datasource delegate
extension ContactsViewController {
    
    //한글 몇번째 리턴해줌
    func getHangul(num : Int) -> String {
        //        let hangle = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
        let hangle = ["ㄱ","ㄴ","ㄷ","ㄹ","ㅁ","ㅂ","ㅅ","ㅇ","ㅈ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
        return hangle[num]
    }
    
    //초성 나누기
    func checkSplit(name: String, num : Int) -> Bool {
        let dic = name.map { return $0 }
        let text = dic[0]
        var getValue = ""
        var valueString = ""
        let val = UnicodeScalar(String(text))?.value
        if ( val! >= 0xAC00 && val! <= 0xD7A3 ) {
            var first = (val! - 0xac00) / 28 / 21
            if first >= 13 {first = first - 5}
            else if first >= 10 {first = first - 4 }
            else if first >= 8 {first = first - 3 }
            else if first >= 4 { first = first - 2 }
            else if first >= 1 { first = first - 1 }
            getValue =  getHangul(num: Int(first))
        }
        
        if let value = index.arrIndexSection.object(at: num) as? String {
            valueString = String(value)
        }
        
        if getValue == valueString {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var compare = 0
        if let count = memberList?.memberList.count {
            compare = count
        }
        
        if memberList?.memberList.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotSearchTableViewCell", for: indexPath) as! NotSearchTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
            if checkSplit(name: sorted[indexPath.row].name, num: indexPath.section) == true {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHomeTableViewCell", for: indexPath) as! DetailHomeTableViewCell
                
                cell.userImage?.layer.cornerRadius = (cell.userImage?.frame.width)!/2
                cell.nameLabel?.text = sorted[indexPath.row].name
                cell.phoneLabel?.text = sorted[indexPath.row].phone
                return cell
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeView(alpha: true)
        self.selected.updateValue((memberList?.memberList[indexPath.row].name)!, forKey: (memberList?.memberList[indexPath.row].phone)!)
        updateCount()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        updateCount()
        self.selected.removeValue(forKey: (memberList?.memberList[indexPath.row].phone)!)
        if tableView.indexPathsForSelectedRows?.count == nil{
            changeView(alpha: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        var compare = 0
        if let count = memberList?.memberList.count {
            compare = count
        }
        
        for i in 0 ..< compare {
            if checkSplit(name: sorted[i].name, num: section) == true {
                count = count + 1
            }
        }
        
        return count
    }
}

//MARK: contacts index header part
extension ContactsViewController {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return index.arrIndexSection.count
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        return self.index.arrIndexSection as? [String]
    }
    
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return index.arrIndexSection.object(at: section) as? String
    }
    
}

//MARK: 셀 선택시 뷰 변경
extension ContactsViewController {
    
    func updateCount(){
        if let list = tableView.indexPathsForSelectedRows {
            saveLabel.text = "\(list.count)"
        }
    }
    
    func changeView(alpha: Bool){
        if(alpha == true){
            cellView.alpha = 1
            saveLabel.alpha = 1
            cellSelected.alpha = 0.5
        }else {
            cellView.alpha = 0
            saveLabel.alpha = 0
            cellSelected.alpha = 0
        }
    }
}

//MARK: Notifications
extension ContactsViewController {
    
    func createObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.searchMemberNoti(_:)), name: searchMember, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.searchMemberDoneNoti), name: searchMemberDone, object: nil)
    }
    
    @objc func searchMemberDoneNoti(){
        nothingView.alpha = 0
        self.selectButton.isEnabled = true
        self.selectAllbutton.isEnabled = true
        
        let parameter = [
            "repositoryId" : ContactsViewController.repoId
        ]
        
        APICollection.sharedAPI.getRepoMember(parameter: parameter) { (result) -> (Void) in
            self.memberList = DetailMemberSet(rawJson: result)
            if let count = self.memberList?.memberList.count {
                self.totalLabel.text = "총 \(count)명"
            }
            self.tableView.reloadData()
        }
    }
    
    @objc func searchMemberNoti(_ notification: Notification){
        
        if let data = notification.userInfo as? [String: String]
        {
            for (_, text) in data
            {
                searchText = text
            }
        }
        guard searchText != nil else{return}
        
        let parameter : Parameters = [
            "memberName" : searchText!,
            "repositoryId" : ContactsViewController.repoId
        ]
        
        Alamofire.request("http://45.63.120.140:40005/repository/memberSearch", method: .get, parameters: parameter).responseJSON { response in
            let json = JSON(response.result.value)
            print(json)
            switch response.result {
            case .success:
                print("search success")
                self.memberList = DetailMemberSet(rawJson: json)
                self.view.endEditing(true)
                if self.memberList?.memberList.count != 0 {
                    self.tableView.reloadData()
                }else{
                    self.nothingView.alpha = 1
                    self.selectButton.isEnabled = false
                    self.selectAllbutton.isEnabled = false
                }
                break
            case .failure:
                print("fail")
                break
            }
        }
    }
}
