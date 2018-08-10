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
   
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        let storyboard = UIStoryboard.init(name: "DetailHome", bundle: nil)
        let nv = storyboard.instantiateViewController(withIdentifier: "DetailHome") as! DetailHomeTableViewController
        navigationController?.pushViewController(nv, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            print("\(self.lastContentOffset),\(scrollView.contentOffset.y)")
            print("move down")
            if scrollView.contentOffset.y > 128 {
                print("view 땡겨라")
            }
          

        } else if (self.lastContentOffset > scrollView.contentOffset.y) {
            // moved to bottom
            print("\(self.lastContentOffset),\(scrollView.contentOffset.y)")
            print("move up")
            if scrollView.contentOffset.y < 128 {
                print("view 늘려라")
            }
        }
    }
    
//    func scrollViewDidScroll(scrollView: UIScrollView!) {
//        if (self.lastContentOffset > scrollView.contentOffset.y) {
//            // move up
//            print("move up")
//        }
//        else if (self.lastContentOffset < scrollView.contentOffset.y) {
//            // move down
//            print("move down")
//        }
//
//        // update the new position acquired
//        self.lastContentOffset = scrollView.contentOffset.y
//    }
    
    @objc func buttonPressed(){
        print("button pressed")
        let vc = UIViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

