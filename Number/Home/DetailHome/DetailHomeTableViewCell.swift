//
//  DetailHomeTableViewCell.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 24..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class DetailHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
