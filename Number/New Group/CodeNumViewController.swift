//
//  CodeNumViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import SideMenu

class CodeNumViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func pressedSosik(_ sender: Any) {
        let nv = self.storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") 
        present(nv!, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController

        let label = UILabel()
        label.text = ""
        imageView.backgroundColor = .black
        
        addButton()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func addButton(){
        let groupCreate = UIButton()
        groupCreate.backgroundColor = .black
        groupCreate.frame = CGRect(x: view.frame.width - 80, y: view.frame.height - 80, width: 50, height: 50)
        self.view.addSubview(groupCreate)
        groupCreate.addTarget(self, action: #selector(self.createGroup), for: UIControlEvents.touchUpInside)
    }
    
    @objc func createGroup(){
        let storyboard = UIStoryboard(name: "GroupCreate", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GroupCreate") as! GroupCreateViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
