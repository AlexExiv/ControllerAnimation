//
//  SUFromFrameContollerAnimation.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 28/01/2019.
//  Copyright © 2019 Appomart. All rights reserved.
//

import UIKit

public protocol AAFromFrameProtocol
{
    var fromFrame: CGRect { get };
}

class AAFromFrameContollerAnimation: AAControllerAnimation
{
    override func animateTransition( using transitionContext: UIViewControllerContextTransitioning )
    {
        super.animateTransition( using: transitionContext );
        
        guard let from = transitionContext.view( forKey: .from ), let to = transitionContext.view( forKey: .to ) else { return; };
        
        let up = presentState == .present ? to : from;
        let down = presentState == .present ? from : to;
        
        transitionContext.containerView.addSubview( down );
        transitionContext.containerView.addSubview( up );
        
        let state = presentState;
        let fromFrame = state == .present ? (presenting as! AAFromFrameProtocol).fromFrame : presented.view.frame;
        let toFrame = state == .present ? presented.view.frame : (presenting as! AAFromFrameProtocol).fromFrame;
        
        presented.view.alpha = state == .present ? 0.5 : 1.0;
        presented.view.frame = fromFrame;
        
        weak var _self = self;
        UIView.animate( withDuration: duration, animations:
        {
            _self?.presented.view.alpha = state == .present ? 1.0 : 0.0;
            _self?.presented.view.frame = toFrame;
        })
        {
            (b) in
            
            if state == .present && transitionContext.transitionWasCancelled
            {
                _self?.presented.view.removeFromSuperview();
            }
            
            transitionContext.completeTransition( !transitionContext.transitionWasCancelled );
        }
    }
}
