//
//  HomeViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var interactor : Interactor?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myName: UILabel!
    
    var lastContentOffset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName:"HomeTableViewCell",bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.cellView.layer.cornerRadius = 10
        cell.cellView.layer.borderWidth = 1
        cell.cellView.layer.borderColor = UIColor(red:196/255, green:197/255, blue:214/255, alpha: 1).cgColor
        cell.groupImage.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
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
            let nv = storyboard.instantiateViewController(withIdentifier: "DetailHome") as! ContactsViewController
            self.navigationController?.pushViewController(nv, animated: true)
        }
        
        alert.addAction(noAlert)
        alert.addAction(okAlert)
        present(alert,animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            print("\(self.lastContentOffset),\(scrollView.contentOffset.y)")
            print("move down")
            if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < 300 {
                print("view 땡겨라")
                
                var scroll = ["scroll" :scrollView.contentOffset.y]
                let name = Notification.Name(rawValue:changeViewNotificationKey)
                NotificationCenter.default.post(name: name, object: nil, userInfo: scroll)
            }
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
            

        } else if (self.lastContentOffset > scrollView.contentOffset.y) {
            print("\(self.lastContentOffset),\(scrollView.contentOffset.y)")
            print("move up")
            if scrollView.contentOffset.y > 200 {
                print("view 늘려라")
                let name = Notification.Name(rawValue:changeBackViewNotificationKey)
                NotificationCenter.default.post(name: name, object: nil)
                UIView.animate(withDuration: 0.1, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @objc func buttonPressed(){
        let vc = UIViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Transition Delegate
extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor?.hasStarted == true ? interactor : nil
    }
}


