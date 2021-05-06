//
//  SUFromFrameContollerAnimation.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 28/01/2019.
//  Copyright © 2019 Appomart. All rights reserved.
//

import UIKit

class AAFromFrameContollerAnimation: AAControllerAnimation
{
    let fromFrame: CGRect
    
    init( presented: UIViewController, presenting: UIViewController, delegateId: String, state: AAControllerAnimation.State, duration: TimeInterval, fromFrame: CGRect )
    {
        self.fromFrame = fromFrame
        super.init( presented: presented, presenting: presenting, delegateId: delegateId, state: state, duration: duration )
    }

    override func animateTransition( using transitionContext: UIViewControllerContextTransitioning )
    {
        super.animateTransition( using: transitionContext )
        
        let state = presentState
        let fromFrame = state == .present ? self.fromFrame : presented.view.frame
        let toFrame = state == .present ? presented.view.frame : self.fromFrame
        
        let animated: UIView
        if state == .present
        {
            animated = transitionContext.view( forKey: .to )!
        }
        else
        {
            animated = transitionContext.view( forKey: .from )!
        }
        
        transitionContext.containerView.addSubview( animated )
        
        animated.alpha = state == .present ? 0.5 : 1.0
        animated.frame = fromFrame
        animated.setNeedsLayout()
        animated.layoutIfNeeded()

        UIView.animate( withDuration: duration, animations:
        {
            animated.alpha = state == .present ? 1.0 : 0.0
            animated.frame = toFrame
            animated.setNeedsLayout()
            animated.layoutIfNeeded()
        })
        {
            (b) in

            if state == .present && transitionContext.transitionWasCancelled
            {
                animated.removeFromSuperview()
            }
            
            transitionContext.completeTransition( !transitionContext.transitionWasCancelled )
        }
    }
}
