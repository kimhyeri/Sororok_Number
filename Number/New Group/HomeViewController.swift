//
//  HomeViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var myName: UILabel!
    
    var lastContentOffset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName:"HomeTableViewCell",bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        
        let buttonView = UIView()
        buttonView.frame = CGRect(x: view.frame.midX, y: view.frame.midY, width: 50, height: 50)
        buttonView.backgroundColor = .red
        
        let button = UIButton()
        button.frame = CGRect(x: view.frame.midX, y: view.frame.midY, width: 30, height: 30)
        button.addTarget(self, action: #selector(buttonPressed), for: UIControlEvents.touchUpInside)
        buttonView.addSubview(button)
        view.addSubview(buttonView)

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
//
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        self.lastContentOffset = scrollView.contentOffset.y
//        print("scroll start")
//        myName.text = "희은"
//        myImage.frame = CGRect(x:myImage.center.x , y: myImage.center.y , width: 50, height: 50)
//
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            print("\(self.lastContentOffset),\(scrollView.contentOffset.y)")

        } else if (self.lastContentOffset > scrollView.contentOffset.y) {
            // moved to bottom
            print("\(self.lastContentOffset),\(scrollView.contentOffset.y)")

        } else {
            // didn't move
               print("scroll not move")
        }
    }
    
    @objc func buttonPressed(){
        print("button pressed")
        let vc = UIViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

