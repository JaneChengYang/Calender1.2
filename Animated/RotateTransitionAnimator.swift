//
//  RotateTransitionAnimator.swift
//  Calender
//
//  Created by Simon on 2018/9/7.
//  Copyright © 2018年 Simon. All rights reserved.
//

import Foundation
import UIKit
class RotateTransitionAnimator:NSObject,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate{
    let duration = 1.0
    var isPresenting = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
            return
        }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        let container = transitionContext.containerView
        let rotateOut = CGAffineTransform(rotationAngle: -90 * CGFloat.pi / 180)
        fromView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        toView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        fromView.layer.position = CGPoint(x: 0, y: 0)
        toView.layer.position = CGPoint(x: 0, y: 0)
        toView.transform = rotateOut
        container.addSubview(fromView)
        container.addSubview(toView)
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            if self.isPresenting{
                fromView.transform = rotateOut
                fromView.alpha = 0.5
                toView.transform = CGAffineTransform.identity
                toView.alpha = 1
            }else{
                fromView.alpha = 0.5
                fromView.transform = rotateOut
                toView.alpha = 1
                toView.transform = CGAffineTransform.identity
            }
        }) { (finised) in
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

