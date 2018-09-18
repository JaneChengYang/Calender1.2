//
//  SlideRightTransitionAnimator.swift
//  Calender
//
//  Created by Simon on 2018/9/7.
//  Copyright © 2018年 Simon. All rights reserved.
//

import Foundation
import UIKit
class SlideRightTransitionAnimator:NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning{
    let duration = 1.0
    var isPresenting = false
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
            return
        }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)else {
            return
        }
        let container = transitionContext.containerView
        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
        let offScreen = CGAffineTransform(translationX: container.frame.width, y: 0)
        if isPresenting{
            toView.transform = offScreenLeft
        }
        if isPresenting{
            container.addSubview(fromView)
            container.addSubview(toView)
        }else{
            container.addSubview(toView)
            container.addSubview(fromView)
        }
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            if self.isPresenting{
                fromView.transform = offScreen
                fromView.alpha = 0.5
                toView.transform = CGAffineTransform.identity
                toView.alpha = 1
            }else{
                fromView.transform = offScreenLeft
                toView.alpha = 1
                toView.transform = CGAffineTransform.identity
                fromView.alpha = 0.5
            }
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
        
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}

