//
//  TwoMainView.swift
//  Number
//
//  Created by hyerikim on 2018. 9. 19..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import SideMenu

extension TwoViewController {
    
    @objc func changedName(){
        nameLabel.text = "\(UserDefaults.standard.string(forKey: "name")!)님"
    }
    
    func defaultView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName:"HomeTableViewCell",bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.register(UINib(nibName:"NothingTableViewCell",bundle: nil), forCellReuseIdentifier: "NothingTableViewCell")
        
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        defaultButton = Int(self.imageButton.frame.origin.y)
        defaultLabel = Int(self.nameLabel.frame.origin.y)
        
        if let name = UserDefaults.standard.string(forKey: "name") {
            nameLabel.text = "\(name)님"
            topNameLabel.text = "\(name)님"
        }
        
        nameShadow.frame = CGRect(x: nameShadow.frame.origin.x, y: nameShadow.frame.origin.y , width: nameLabel.frame.width + 6 , height: nameShadow.frame.height )
        
        if let imageData =  UserDefaults.standard.data (forKey: "imageName") {
            if let image = UIImage(data: imageData) {
                imageButton.setImage(image, for: .normal)
                imageSecondView.setImage(image, for: .normal)
                imageButton.layer.cornerRadius = imageButton.frame.width/2
                imageSecondView.layer.cornerRadius = imageSecondView.frame.width/2
            }
        }
        
        self.navigationController!.navigationBar.topItem!.title = ""
        floatingView.layer.cornerRadius = floatingView.frame.width/2
        navigationBarHeight = navigationBarHeight + (self.navigationController?.navigationBar.frame.height)!
        imageSecondView.layer.cornerRadius = self.imageSecondView.frame.size.width / 2
        nothingLabel1.alpha = 0
        nothingLabel2.alpha = 0
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
            
            if let status = repoList?.dataList[indexPath.row].authority {
                if (flag == false) {
                    cell.statusLabel.alpha = 1
                    cell.labelView.alpha = 0.3
                    if status == 0 {
                        cell.statusLabel.text = authority.host.rawValue
                    } else {
                        cell.statusLabel.text = authority.member.rawValue
                    }
                } else {
                    cell.statusLabel.alpha = 0
                    cell.labelView.alpha = 0
                }
            }
            
            if let groupImg = repoList?.dataList[indexPath.row].imageName {
                if (groupImg == "" || groupImg == " ") {
                    cell.groupImage?.image = UIImage(named: groupDefaultImages[indexPath.row % groupDefaultImages.count])
                } else {
                    let url = URL(string: APICollection.sharedAPI.imageUrl + groupImg)
                    cell.groupImage.kf.setImage(with: url)
                }
            }
            
            cell.labelView.layer.cornerRadius = 10
            cell.cellView.layer.cornerRadius = 10
            cell.cellView.layer.borderWidth = 1
            cell.cellView.layer.borderColor = UIColor(red:196/255, green:197/255, blue:214/255, alpha: 1).cgColor
            cell.groupImage.layer.cornerRadius = 10
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if repoList?.dataList.count != 0 {
            if repoList?.dataList[indexPath.row].joinFlag == 1 {
                UserDefaults.standard.set(repoList?.dataList[indexPath.row].authority, forKey: "authority")
                let storyboard = UIStoryboard.init(name: "DetailHome", bundle: nil)
                let nv = storyboard.instantiateViewController(withIdentifier: "NV") as! ContactNaviViewController
                ContactsViewController.repoId = repoList?.dataList[indexPath.row].repositoryId
                ContactsViewController.repoName = repoList?.dataList[indexPath.row].name
                self.present(nv, animated: true, completion: nil)
            }
            if let repositoryId = repoList?.dataList[indexPath.row].repositoryId {
                createAlert(data: repositoryId)
            }
        }
    }
}


//MARK: ScrollViewDeleate animation 버전2

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
 
        if (scrollView.contentSize.height > tableView.frame.height * 2 ){
          
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
}
