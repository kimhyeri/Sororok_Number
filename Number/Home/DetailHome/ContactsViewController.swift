//
//  ContactsViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 18..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import Contacts

extension Dictionary{
    mutating func changeKey(from: Key, to: Key){
        self[to] = self[from]
        self.removeValue(forKey: from)
    }
}

class ContactsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var cellView: UIImageView!
    @IBOutlet weak var cellSelected: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveLabel: UILabel!
    
    var checkState = false
    var index = DefualtIndex()
    var memberList : DetailMemberSet?
    let contact = CNMutableContact()
    
    func getHangul(num : Int) -> String {
        let hangle = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
        return hangle[num]
        
    }
    
    //repoID 이전단계에서 받는 작업 필요
    override func viewWillAppear(_ animated: Bool) {
        let parameter = [
            "repositoryId" : 53
        ]
        
        APICollection.sharedAPI.getRepoMember(parameter: parameter) { (result) -> (Void) in
            self.memberList = DetailMemberSet(rawJson: result)
            self.tableView.reloadData()
        }
        
        totalLabel.text = "총 \(memberList?.memberList.count)명"
//        let dac = array1.map { return $0.key }
//        for j in 0..<dac.count{
//            let name = dac[j]
//            let text = dac[j].first
//            let val = UnicodeScalar(String(text!))?.value
//            if ( val! >= 0xAC00 && val! <= 0xD7A3 ) {
//                let first = (val! - 0xac00) / 28 / 21
//                let getValue: String =  getHangul(num: Int(first))
//                array1.changeKey(from: name, to: getValue+name)
//            }
//        }
        checkSplit()
    }
    
    func checkSplit() {
//        let dac = memberList?.memberList.map { return $0.key }
//        for j in 0..<dac.count{
//            print(dac[j])
//            let st = "김혜리"
//            print(st.decomposedStringWithCanonicalMapping)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"DetailHomeTableViewCell",bundle: nil), forCellReuseIdentifier: "DetailHomeTableViewCell")
        tableView.register(UINib(nibName:"NotSearchTableViewCell",bundle: nil), forCellReuseIdentifier: "NotSearchTableViewCell")
        defaultView()
    }
    
    func defaultView(){
        let backButton = UIBarButtonItem(image: UIImage(named: "btnCommBackWh"), style: .plain, target: self, action: #selector(ContactsViewController.backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.imageInsets.left = -10
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "btnCommListSetWh"), style: .done, target: self, action: #selector(ContactsViewController.pressedButton))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    @objc func backButtonPressed() {
        let storyboard = UIStoryboard.init(name: "CodeNum", bundle: nil)
        let bv = storyboard.instantiateViewController(withIdentifier: "ST") as! CustomNaviViewController
        self.present(bv, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    @objc func pressedButton(){
        let storyboard = UIStoryboard.init(name: "ManagerGroup", bundle: nil)
        let uv = storyboard.instantiateViewController(withIdentifier: "ManagerGroup") as! ManagerGroupViewController
        self.navigationController?.pushViewController(uv, animated: true)
    }
    
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
    
    @IBAction func saveButtonPressed(_ sender: Any) {
//        sort()
        let storyboard = UIStoryboard.init(name: "Progress", bundle: nil)
        let nv = storyboard.instantiateViewController(withIdentifier: "Progress") as! ProgressViewController
        self.present(nv, animated: true, completion: nil)
    }
}

//MARK: tableview datasource delegate
extension ContactsViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if memberList?.memberList.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotSearchTableViewCell", for: indexPath) as! NotSearchTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHomeTableViewCell", for: indexPath) as! DetailHomeTableViewCell
            cell.nameLabel?.text = memberList?.memberList[indexPath.row].name
//            let predicate = NSPredicate(format: "SELF beginswith[c] %@", index.arrIndexSection.object(at: indexPath.section) as! CVarArg)
//            cell.userImage?.layer.cornerRadius = (cell.userImage?.frame.width)!/2
//            let dic = memberList?.memberList.map { return $0.key }
//            let arrContacts = (dic as NSArray).filtered(using: predicate) as NSArray
//            cell.nameLabel?.text = arrContacts.object(at: indexPath.row) as? String
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeView(alpha: true)
        updateCount()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        updateCount()
        if tableView.indexPathsForSelectedRows?.count == nil{
            changeView(alpha: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let predicate = NSPredicate(format: "SELF beginswith[c] %@", index.arrIndexSection.object(at: section) as! CVarArg)
//        let dic = memberList?.memberList.map { return $0.key }
//        let arrContacts = (dic as NSArray).filtered(using: predicate) as NSArray
        if let count = memberList?.memberList.count {
            return count
        }
        return 1
        
    }
}

//MARK: update selected cell
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

//MARK: save contacts
extension ContactsViewController{
    
//    func sort() {
//        let name = memberList?.memberList.map { return $0.key }
//        let number = memberList?.memberList.map { return $0.value }
//        for i in 0..<memberList?.memberList.count {
//            contact.givenName = name[i]
//            contact.phoneNumbers = [CNLabeledValue(
//                label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue: number[i]))]
//
//            self.contactSave()
//        }
//
//    }
    
    func contactSave(){
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier:nil)
        try! store.execute(saveRequest)
    }
}
