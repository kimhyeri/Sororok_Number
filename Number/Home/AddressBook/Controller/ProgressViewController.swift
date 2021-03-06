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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.contactSave(_:)), name: save, object: nil)
    }
    
    @objc func contactSave(_ notification: Notification){

        let store = CNContactStore()
        let userDict = notification.userInfo as! NSDictionary
        let names = userDict.allValues
        let numbers = userDict.allKeys

        let countName = names.count
        totalLabel.text = String(countName)

        for i in 0..<countName {
            let contact = CNMutableContact()
            contact.givenName = names[i] as! String
            contact.phoneNumbers = [CNLabeledValue(
                label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue:"\(numbers[i] as! String)"))]
            contactList.append(contact)
        }

        let saveRequest = CNSaveRequest()

        for i in 0..<contactList.count {
            saveRequest.add(contactList[i], toContainerWithIdentifier: nil)
            if i == contactList.count-1 {
                do {
                    try? store.execute(saveRequest)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.showToast(message: "저장 성공")
                        let st = UIStoryboard.init(name: "DetailHome", bundle: nil)
                        let vc = st.instantiateViewController(withIdentifier: "NV") as! ContactNaviViewController
                        self.present(vc, animated: true, completion: nil)
                    }
                } catch{
                    showToast(message: "저장 실패")
                }
            }
        }
    }
}
