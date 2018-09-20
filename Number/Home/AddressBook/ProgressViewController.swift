//
//  ProgressViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import Contacts

class ProgressViewController: UIViewController {
    
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    
    let save = Notification.Name(rawValue: saveNotificationKey)
    var contactList = [CNMutableContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObserver()
        defaultView()
    }
    
    func defaultView() {
        iconView.layer.cornerRadius = iconView.frame.width/2
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.contactSave(_:)), name: save, object: nil)
    }
    
    @objc func contactSave(_ notification: Notification){
        print(notification)
        let store = CNContactStore()

        let userDict = notification.userInfo as! NSDictionary
        let names = userDict.allValues
        totalLabel.text = String(names.count)
        let numbers = userDict.allKeys

        for i in 0..<names.count
        {
            let contact = CNMutableContact()
            contact.givenName = names[i] as! String
            contact.phoneNumbers = [CNLabeledValue(
                label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue:"\(numbers[i] as! String)"))]
            contactList.append(contact)
        }

        let saveRequest = CNSaveRequest()

        for i in 0..<contactList.count{
            saveRequest.add(contactList[i], toContainerWithIdentifier: nil)
            if i == contactList.count-1{
                do
                {
                    try? store.execute(saveRequest)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        let st = UIStoryboard.init(name: "DetailHome", bundle: nil)
                        let vc = st.instantiateViewController(withIdentifier: "NV") as! ContactNaviViewController
                        self.present(vc, animated: true, completion: nil)
                    }
                }
                catch
                {
                    showToast(message: "저장 실패")
                }
            }
        }
    }
}
