//
//  SearchView.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 18..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    var searchBar : UISearchBar!
    let blueColor = UIColor.init(red: 52/255, green: 58/255, blue: 207/255, alpha: 1)
    
    override func awakeFromNib()
    {
        // the actual search barw
        self.searchBar = UISearchBar(frame: self.frame)
        self.searchBar.clipsToBounds = true
        self.searchBar.layer.cornerRadius = 5
        
        self.addSubview(self.searchBar)
        
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.placeholder = "찾으려는 그룹명 검색"
        
        let leadingConstraint = NSLayoutConstraint(item: self.searchBar, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 20)
        let trailingConstraint = NSLayoutConstraint(item: self.searchBar, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -20)
        let yConstraint = NSLayoutConstraint(item: self.searchBar, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        self.addConstraints([yConstraint, leadingConstraint, trailingConstraint])
        
        self.searchBar.backgroundColor = UIColor.clear
        self.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.searchBar.tintColor = UIColor.clear
        self.searchBar.isTranslucent = true
        
        for s in self.searchBar.subviews[0].subviews {
            if s is UITextField {
                s.layer.borderWidth = 1.0
                s.layer.cornerRadius = 10
                s.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let bottomRect = CGRect(x: 0, y: self.frame.height/2, width: self.frame.size.width, height: self.frame.height / 2)
        UIColor.white.set()
        UIRectFill(bottomRect)
    }
    
}
