//
//  ScrollView.swift
//  Number
//
//  Created by hyerikim on 02/11/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import Foundation

//MARK: ScrollViewDeleate animation 버전2

extension TwoViewController : UIScrollViewDelegate {
    
    func changeView(){
        if movedView == false{
            searchView.frame = CGRect(x: 0, y: self.firstView.frame.height , width: self.view.frame.width, height: 38)
            tableView.frame = CGRect(x: 0, y: self.firstView.frame.height + self.searchView.frame.height, width: self.view.frame.width, height: self.view.frame.height - (firstView.frame.height + searchView.frame.height))
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentSize.height > tableView.frame.height * 2 ){
            
            scrollView.decelerationRate = UIScrollViewDecelerationRateFast
            let y = 227 - scrollView.contentOffset.y
            let h = max(65, y)
            let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: h)
            firstView.frame = rect
            
            let x = 65 + -scrollView.contentOffset.y
            let a = min(x, 90)
            let rect1 = CGRect(x: 10, y: a, width: 355, height: 146)
            insideView.frame = rect1
            
            changeView()
            
            if (h < 130) {
                let rect2 = CGRect(x: 0, y: 65 - h , width: view.bounds.width, height: 65)
                topView.frame = rect2
            }
            
            if (self.lastContentOffset < scrollView.contentOffset.y) {
                insideView.alpha = 1 - ( tableView.contentOffset.y * 0.01)
            }
            
        }
        
    }
}
