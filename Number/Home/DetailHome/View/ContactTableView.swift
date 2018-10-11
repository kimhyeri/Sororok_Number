//
//  ContactTableView.swift
//  Number
//
//  Created by hyerikim on 12/10/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import UIKit

//MARK: tableview datasource delegate
extension ContactsViewController {
    
    //한글 몇번째 리턴해줌
    func getHangul(num : Int) -> String {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHomeTableViewCell", for: indexPath) as! DetailHomeTableViewCell
        
        if matchData[indexPath.section] != nil {
            cell.nameLabel.text = matchData[indexPath.section]![indexPath.row].name
            cell.phoneLabel.text = matchData[indexPath.section]![indexPath.row].phone
            cell.userImage.image = UIImage(named: "girl")
            DispatchQueue.global().async {
                guard let url = URL(string: APICollection.sharedAPI.imageUrl + self.matchData[indexPath.section]![indexPath.row].imageName) else {return}
                
                DispatchQueue.main.async {
                    if let index : IndexPath = tableView.indexPath(for: cell) {
                        if index.row == indexPath.row {
                            cell.userImage.kf.setImage(with: url)
                            cell.userImage?.layer.cornerRadius = cell.userImage.frame.width / 2
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeView(alpha: true)
        self.selected.updateValue(matchData[indexPath.section]![indexPath.row].name, forKey: (matchData[indexPath.section]![indexPath.row].phone))
        updateCount()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        updateCount()
        self.selected.removeValue(forKey: (matchData[indexPath.section]![indexPath.row].phone))
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
                if let _ = matchData[section] {
                    matchData[section]?.append(sorted[i])
                }else{
                    matchData.updateValue([sorted[i]], forKey: section)
                }
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
