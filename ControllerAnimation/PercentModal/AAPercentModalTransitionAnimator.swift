//
//  PercentModalTransitionAnimator.swift
//  MetalTest
//
//  Created by ALEXEY ABDULIN on 30/11/2018.
//  Copyright © 2018 ALEXEY ABDULIN. All rights reserved.
//

import UIKit


internal class AAPercentModalTransitionAnimator: AAControllerAnimation, AAPercentModalStride
{
    init( presented: UIViewController, presenting: UIViewController, delegateId: String, state: AAControllerAnimation.State )
    {
        super.init( presented: presented, presenting: presenting, delegateId: delegateId, state: state, duration: 0.0 );
    }
    
    override func animateTransition( using transitionContext: UIViewControllerContextTransitioning )
    {
        super.animateTransition( using: transitionContext );
        
        guard let animatedVC = transitionContext.viewController( forKey: presentState == .present ? .to : .from ) else { return }
        
        transitionContext.containerView.addSubview( animatedVC.view );
        switch direction
        {
        case .left, .right:
            animatedVC.view.transform = CGAffineTransform( translationX: presentState == .present ? (direction == .left ? -1.0 : 1.0)*totalStride : 0.0, y: 0 );
        case .top, .bottom:
            animatedVC.view.transform = CGAffineTransform( translationX: 0, y: presentState == .present ? (direction == .top ? -1.0 : 1.0)*totalStride : 0.0 );
        }

        UIView.animate( withDuration: animationDuration, animations:
        {
            [weak self] () in
            
            if let _self = self
            {
                switch _self.direction
                {
                case .left, .right:
                    animatedVC.view.transform = CGAffineTransform( translationX: _self.presentState == .present ? 0.0 : (_self.direction == .left ? -1.0 : 1.0)*_self.totalStride, y: 0 );
                case .top, .bottom:
                    animatedVC.view.transform = CGAffineTransform( translationX: 0, y: _self.presentState == .present ? 0.0 : (_self.direction == .top ? -1.0 : 1.0)*_self.totalStride );
                }
            }
            
        })
        {
            [weak self] b in
            
            if let _self = self, _self.presentState == .present, transitionContext.transitionWasCancelled
            {
                animatedVC.view.removeFromSuperview();
            }
            
            transitionContext.completeTransition( !transitionContext.transitionWasCancelled );
        }
    }
}

