//
//  AddressViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 27..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import Contacts

class AddressViewController: UIViewController {
    
    let contact = CNMutableContact()

    @IBAction func buttonPressed(_ sender: Any) {
        contact.givenName = "이름"
        contact.familyName = "성"
//        contact.emailAddresses =
        
        contact.phoneNumbers = [CNLabeledValue(
            //뭐로 저장시키지? 회의해봐야할듯
//            label:CNLabelPhoneNumberiPhone,
            label:CNLabelPhoneNumberMain,
            value:CNPhoneNumber(stringValue:"010-1231-0126"))]
        
        self.contactSave()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func contactSave(){
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier:nil)
        try! store.execute(saveRequest)
    }
}
