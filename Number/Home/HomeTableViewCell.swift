//
//  HomeTableViewCell.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var groupImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
