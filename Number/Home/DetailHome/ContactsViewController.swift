//
//  ContactsViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 18..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

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
    
    var array:[String:String] = ["가혜리":"010-1234-1234", "박혜리":"010-1234-1234","정혜리":"010-1234-1234","미혜리":"010-1234-1234","어혜리":"010-1234-1234","푸혜리":"010-1234-1234", "타혜리":"010-1234-1234" ,"Kim":"010-123-1123","park":"010-123-1123","dim":"010-123-1123","fim":"010-123-1123"]
    
    var array1:[String:String] = ["가혜리":"010-1234-1234", "박혜리":"010-1234-1234","정혜리":"010-1234-1234","미혜리":"010-1234-1234","어혜리":"010-1134-1234","푸혜리":"010-1234-1234", "타혜리":"010-1234-1234" ,"Kim":"010-1243-1123","park":"110-123-1123","dim":"010-1623-1123","fim":"010-1283-1123"]
    
    override func viewWillAppear(_ animated: Bool) {
        totalLabel.text = "총 \(array1.count)명"
        let dac = array.map { return $0.key }
        for j in 0..<dac.count{
            let name = dac[j]
            let text = dac[j].first
            let val = UnicodeScalar(String(text!))?.value
            if ( val! >= 0xAC00 && val! <= 0xD7A3 ) {
                let first = (val! - 0xac00) / 28 / 21
                let i = String(UnicodeScalar(0x1100 + first)!)
                
                let y = ((val! - 0xac00) / 28) % 21
                let j =  String(UnicodeScalar(0x1161 + y)!)
                
                let z = (val! - 0xac00) % 28
                let k = String(UnicodeScalar(0x11a6 + 1 + z)!)
                
                array1.changeKey(from: name, to: "\(i) \(j) \(k) "+name)
                
            }
        }
    }
    
    func splitText(text: String) -> Bool {
        guard let text = text.last else { return false }
        let val = UnicodeScalar(String(text))?.value
        guard let value = val else { return false }
        if ( value >= 0xAC00 && value <= 0xD7A3 ) {
            let x = (value - 0xac00) / 28 / 21
            
            let i = UnicodeScalar(0x1100 + x) //초성
            
            print("\(x)\(i!)")
            
        }
        return true
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //데이터 없을때
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "NotSearchTableViewCell", for: indexPath) as! NotSearchTableViewCell
        //return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHomeTableViewCell", for: indexPath) as! DetailHomeTableViewCell
        let predicate = NSPredicate(format: "SELF beginswith[cd] %@", index.arrIndexSection.object(at: indexPath.section) as! CVarArg)
        cell.userImage?.layer.cornerRadius = (cell.userImage?.frame.width)!/2
        let dic = array1.map { return $0.key }
        //        let num = array1.map {return $0.value}
        let arrContacts = (dic as NSArray).filtered(using: predicate) as NSArray
        cell.nameLabel?.text = arrContacts.object(at: indexPath.row) as? String
        return cell
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
        let predicate = NSPredicate(format: "SELF beginswith[c] %@", index.arrIndexSection.object(at: section) as! CVarArg)
        let dic = array1.map { return $0.key }
        let arrContacts = (dic as NSArray).filtered(using: predicate) as NSArray
        print(arrContacts)
        return arrContacts.count
        
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
        let storyboard = UIStoryboard.init(name: "Progress", bundle: nil)
        let nv = storyboard.instantiateViewController(withIdentifier: "Progress") as! ProgressViewController
        self.present(nv, animated: true, completion: nil)
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
