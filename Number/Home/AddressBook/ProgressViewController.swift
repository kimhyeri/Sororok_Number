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
    
    let contact = CNMutableContact()
    let save = Notification.Name(rawValue: saveNotificationKey)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObserver()

        iconView.layer.cornerRadius = iconView.frame.width/2
        contact.givenName = "이름"
        contact.familyName = "성성"

        contact.phoneNumbers = [CNLabeledValue(
            label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue:"010-1231-0126"))]
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
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier:nil)
        do{
            try store.execute(saveRequest)
     
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                let st = UIStoryboard.init(name: "DetailHome", bundle: nil)
                let vc = st.instantiateViewController(withIdentifier: "NV") as! ContactNaviViewController
                self.present(vc, animated: true, completion: nil)
            }
            print("Done")
        } catch let err{
            showToast(message: "저장 실패")
            print("Failed to save the contact. \(err)")
        }
    }

//    public func createAndSaveContact(userData : AnyObject)
//    {
//        let userDict = userData as! NSDictionary
//        let contactNew = CNMutableContact()
//        let homePhone = CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue: userDict.objectForKey("contact_phone") as! String))
//        let homeEmail = CNLabeledValue(label:CNLabelHome, value: userDict.objectForKey("contact_email") as! String)
//        contactNew.givenName = userDict.objectForKey("contact_name") as! String
//        contactNew.phoneNumbers = [homePhone]
//        contactNew.emailAddresses = [homeEmail]
//        let request = CNSaveRequest()
//        request.addContact(contactNew, toContainerWithIdentifier: nil)
//        do{
//            try store.executeSaveRequest(request)
//
//            print("Done")
//
//        } catch let err{
//            print("Failed to save the contact. \(err)")
//        }
//    }
    
}
