//
//  MyPageViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 23..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import Photos

class MyPageViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var numText: UITextField!
    
    var defaultFrame : CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        defaultView()
    }
    
    func defaultView(){
        nameText.delegate = self
        numText.delegate = self
        emailText.delegate = self
        
        self.title = "마이페이지"
        defaultFrame = textView.frame
        nameText.attributedPlaceholder = NSAttributedString(string: "이름", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        emailText.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        numText.attributedPlaceholder = NSAttributedString(string: "전화번호", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        myImage.layer.cornerRadius = myImage.frame.width/2
        myImage.backgroundColor = .black
        let saveButton = UIBarButtonItem(title: "저장",  style: .plain, target: self, action: #selector(self.saveButton))
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        textView.frame = defaultFrame!
    }
    
    @objc func saveButton(){
        print("Saved server")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        let popUp = UIStoryboard(name: "Logout", bundle: nil).instantiateViewController(withIdentifier: "Logout") as! LogoutViewController
        popUp.modalPresentationStyle = .overCurrentContext
        self.present(popUp, animated: false, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewUp()
    }
    
    func viewUp() {
        textView.frame = CGRect(x: 0, y: 65, width: self.view.frame.width, height: textView.frame.height)
    }
    
    @IBAction func albumButtonPressed(_ sender: Any) {
        let st = UIStoryboard.init(name: "MyPage", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "Album") as! AlbumViewController
        vc.albumSelectionDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension MyPageViewController : AlbumSelectionDelegate{
    func didSelectImage(asset: PHAsset) {
        var img: UIImage?
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.version = .original
        options.isSynchronous = true
        manager.requestImageData(for: asset, options: options) { data, _, _, _ in
            
            if let data = data {
                img = UIImage(data: data)
            }
        }
        myImage.image = img
    }
}

