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

    @IBOutlet weak var cellView: UIImageView!
    @IBOutlet weak var cellSelected: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var saveLabel: UILabel!
    
    var checkState = false
    var arrIndexSection : NSArray = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","ㄱ","ㄴ","ㄷ","ㄹ","ㅁ","ㅂ","ㅅ","ㅇ","ㅈ","ㅋ","ㅍ","ㅌ","ㅎ"]
    
    var array:[String:String] = ["가혜리":"010-1234-1234", "박혜리":"010-1234-1234","정혜리":"010-1234-1234","미혜리":"010-1234-1234","어혜리":"010-1234-1234","푸혜리":"010-1234-1234", "타혜리":"010-1234-1234" ,"Kim":"010-123-1123","park":"010-123-1123","dim":"010-123-1123","fim":"010-123-1123"]
    
    var array1:[String:String] = ["가혜리":"010-1234-1234", "박혜리":"010-1234-1234","정혜리":"010-1234-1234","미혜리":"010-1234-1234","어혜리":"010-1234-1234","푸혜리":"010-1234-1234", "타혜리":"010-1234-1234" ,"Kim":"010-123-1123","park":"010-123-1123","dim":"010-123-1123","fim":"010-123-1123"]

    override func viewWillAppear(_ animated: Bool) {
        let dac = array.map { return $0.key }
        for j in 0..<dac.count{
            let name = dac[j]
            let text = dac[j].first
            let val = UnicodeScalar(String(text!))?.value
            if ( val! >= 0xAC00 && val! <= 0xD7A3 ) {
                let first = (val! - 0xac00) / 28 / 21
                let i = String(UnicodeScalar(0x1100 + first)!)
                array1.changeKey(from: name, to: "i"+name)
            }
        }
//        let dac1 = array1.map { return $0.key }
//        for j in 0..<dac1.count{
//            let name = dac1[j]
//            if( name.contains(" ")){
//                dac1[j].replacingOccurrences(of: " ", with: "")
//                array1.changeKey(from: name, to: dac1[j])
//            }
//        }
//        print("finish1")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"DetailHomeTableViewCell",bundle: nil), forCellReuseIdentifier: "DetailHomeTableViewCell")
        tableView.register(UINib(nibName:"NotSearchTableViewCell",bundle: nil), forCellReuseIdentifier: "NotSearchTableViewCell")

        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "btnCommListSetWh"), style: .done, target: self, action: #selector(ContactsViewController.pressedButton))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //데이터 없을때

        //let cell = tableView.dequeueReusableCell(withIdentifier: "NotSearchTableViewCell", for: indexPath) as! NotSearchTableViewCell
        //return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHomeTableViewCell", for: indexPath) as! DetailHomeTableViewCell
        let predicate = NSPredicate(format: "SELF beginswith[c] %@", arrIndexSection.object(at: indexPath.section) as! CVarArg)
        cell.userImage?.layer.cornerRadius = (cell.userImage?.frame.width)!/2
        let dic = array1.map { return $0.key }
        let arrContacts = (dic as NSArray).filtered(using: predicate) as NSArray
        print(arrContacts)
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
        print(array1)
        let predicate = NSPredicate(format: "SELF beginswith[c] %@", arrIndexSection.object(at: section) as! CVarArg)
        let dic = array1.map { return $0.key }
        let arrContacts = (dic as NSArray).filtered(using: predicate) as NSArray
        return arrContacts.count
      
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
        if sender.tag == 1 {
            sender.setImage(UIImage(named: "icnListCheckOn"), for: .normal)
            sender.setImage(UIImage(named: "icnListCheckOff"), for: .selected)
        }
        if checkState == false {
            checkState = true
            for section in 0..<tableView.numberOfSections {
                for row in 0..<tableView.numberOfRows(inSection: section) {
                    tableView.selectRow(at: IndexPath(row: row, section: section), animated: false, scrollPosition: .none)
                }
            }
            updateCount()
            changeView(alpha: true)
        }else{
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
        self.navigationController?.pushViewController(nv, animated: true)
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
        return arrIndexSection.count
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.arrIndexSection as? [String]
    }
    
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrIndexSection.object(at: section) as? String
    }
    
}
