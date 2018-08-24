//
//  ReviewViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 25..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import StoreKit

class ReviewViewController: UIViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        SKStoreReviewController.requestReview()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
