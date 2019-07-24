//
//  SUOpacityControllerAnimation.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 17/01/2019.
//  Copyright © 2019 Appomart. All rights reserved.
//

import UIKit


class AAOpacityControllerAnimation: AAControllerAnimation
{
    override func animateTransition( using transitionContext: UIViewControllerContextTransitioning )
    {
        super.animateTransition( using: transitionContext );
        
        guard let from = transitionContext.view( forKey: .from ), let to = transitionContext.view( forKey: .to ) else { return; };
        
        let up = presentState == .present ? to : from;
        let down = presentState == .present ? from : to;
        up.alpha = presentState == .present ? 0.0 : 1.0;
        
        transitionContext.containerView.addSubview( down );
        transitionContext.containerView.addSubview( up );
        
        let state = presentState;
        
        UIView.animate( withDuration: duration, animations:
        {
            up.alpha = state == .present ? 1.0 : 0.0;
        })
        {
            (b) in
            
            if state == .present && transitionContext.transitionWasCancelled
            {
                up.removeFromSuperview();
            }
            
            transitionContext.completeTransition( !transitionContext.transitionWasCancelled );
        }
    }
}
