//
//  ViewController.swift
//  UIDynamicDemo
//
//  Created by C on 15/8/4.
//  Copyright (c) 2015年 SiQian. All rights reserved.
//

import UIKit

func local(closure:()->()) {
    closure()
}


class ViewController: UIViewController , UICollisionBehaviorDelegate{
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var dynamicView: UIView!
    var redView: UIView!
    var i: Int = 0
    var collistion: UICollisionBehavior!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        local({
            self.dynamicView = UIView(frame: CGRect(x: 150, y: 100, width: 100, height: 100))
            self.dynamicView.backgroundColor = UIColor.yellowColor()
            self.view.addSubview(self.dynamicView)
        })
        
        local({
            self.redView = UIView(frame: CGRect(x: 0, y: 350, width: 180, height: 25))
            self.redView.backgroundColor = UIColor.redColor()
            self.view.addSubview(self.redView)
        })
    
        
        configDynamicAnimator()
        
    }
    func configDynamicAnimator() {
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [dynamicView])
        collistion = UICollisionBehavior(items: [dynamicView])
        collistion.collisionDelegate = self
        collistion.addBoundaryWithIdentifier("redView", forPath: UIBezierPath(rect: redView.frame))
        collistion.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(gravity)
        animator.addBehavior(collistion)
        
        let itemBehavior = UIDynamicItemBehavior(items: [dynamicView])
        itemBehavior.elasticity = 0.8
        animator.addBehavior(itemBehavior)
        
        
        var outCount = 0
        gravity.action = {
            if outCount%3 == 0 {
                let outLine = UIView(frame: self.dynamicView.bounds)
                outLine.center = self.dynamicView.center
                outLine.alpha = 0.5
                outLine.transform = self.dynamicView.transform
                outLine.backgroundColor = UIColor.clearColor()
                outLine.layer.borderColor = self.dynamicView.layer.presentationLayer().backgroundColor
                outLine.layer.borderWidth = 1
                self.view.addSubview(outLine)
            }
            outCount++
        }
        
        
    }
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
        let yellowView = item as? UIView
        yellowView?.backgroundColor = UIColor.yellowColor()
        UIView.animateWithDuration(0.3, animations: {
            yellowView?.backgroundColor = UIColor.grayColor()
        })
    }

}

