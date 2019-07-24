//
//  SUScaleAnimation.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 29/12/2018.
//  Copyright © 2018 Appomart. All rights reserved.
//

import UIKit

class AAScaleControllerAnimation: AAControllerAnimation
{
    override func animateTransition( using transitionContext: UIViewControllerContextTransitioning )
    {
        super.animateTransition( using: transitionContext );
        
        guard let from = transitionContext.view( forKey: .from ), let to = transitionContext.view(forKey: .to ) else { return; }
        
        let scaledView = presentState == .present ? from : to;
        let startScale = CGFloat( presentState == .present ? 1.0 : 0.8 );
        let endScale = CGFloat( presentState == .present ? 0.8 : 1.0 );
        
        let translatedView = presentState == .present ? to : from;
        let startY = CGFloat( presentState == .present ? transitionContext.containerView.bounds.size.height : 0.0 );
        let endY = CGFloat( presentState == .present ? 0.0 : transitionContext.containerView.bounds.size.height );
        
        let dimmingView = AABlurDimming( style: .dark );
        dimmingView.frame = transitionContext.containerView.bounds;
        
        transitionContext.containerView.addSubview( scaledView );
        transitionContext.containerView.addSubview( dimmingView );
        transitionContext.containerView.addSubview( translatedView );
        
        let delay0 = presentState == .present ? 0.3*duration : 0.0;
        let delay1 = presentState == .present ? 0.0 : 0.3*duration;
        
        scaledView.layer.masksToBounds = true;
        
        translatedView.transform = CGAffineTransform( translationX: 0.0, y: startY );
        UIView.animate( withDuration: duration - delay0, delay: delay0, animations:
        {
            translatedView.transform = CGAffineTransform( translationX: 0.0, y: endY );
        });
        
        let state = presentState;
        dimmingView.alpha = state == .present ? 0.5 : 1.0;
        scaledView.transform = CGAffineTransform( scaleX: startScale, y: startScale );
        UIView.animate( withDuration: duration - delay1, delay: delay1, animations:
        {
            scaledView.layer.cornerRadius = state == .present ? 30.0 : 0.0;
            scaledView.transform = CGAffineTransform( scaleX: endScale, y: endScale );
            dimmingView.alpha = state == .present ? 1.0 : 0.5;
        })
        {
            (b) in
            if state == .present && transitionContext.transitionWasCancelled
            {
                scaledView.removeFromSuperview();
            }
            
            transitionContext.completeTransition( !transitionContext.transitionWasCancelled );
        }
    }
}
