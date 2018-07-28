//
//  CodeNumViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import SideMenu

class CodeNumViewController: UIViewController, UIGestureRecognizerDelegate {

    var interactor = Interactor()

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func pressedSosik(_ sender: Any) {
        let nv = self.storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController")
        present(nv!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
        
        self.view.addGestureRecognizer(panGesture)
        
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

    @IBAction func profilePressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyPage") as! MyPageViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func handlePanGesture(_ sender: UIScreenEdgePanGestureRecognizer){
        let location = sender.translation(in: view)
        let progress = -(location.y / self.view.frame.height)
        print(progress)

        switch sender.state {
        case .began:
            print("began")
            interactor.hasStarted = true
            let nextVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "Home") as! HomeViewController
            nextVC.interactor = self.interactor
            nextVC.transitioningDelegate = nextVC
            self.present(nextVC, animated: true, completion: nil)
        case .changed:
            print("changed")
            interactor.shoudFinish = progress > 0.5
            interactor.update(progress)
        case .cancelled:
            print("cancelled")
            interactor.hasStarted = false
        case .ended:
            interactor.hasStarted = false
            interactor.shoudFinish ? interactor.finish() : interactor.cancel()
        default:
            print("default")
        }
        
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor?.hasStarted == true ? interactor : nil
    }
}


