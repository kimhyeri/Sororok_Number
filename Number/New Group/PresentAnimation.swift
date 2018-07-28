//
//  PresentAnimation.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 29..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import Foundation
import UIKit

class PresentAnimation: NSObject , UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from), let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else{
                return
        }
        
        let containerView = transitionContext.containerView
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            fromVC.view.frame.origin.y -= UIScreen.main.bounds.height
            
        }) { _ in
            fromVC.view.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
