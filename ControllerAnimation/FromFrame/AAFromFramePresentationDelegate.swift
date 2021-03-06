//
//  SUFromFramePresentationDelegate.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 28/01/2019.
//  Copyright © 2019 Appomart. All rights reserved.
//

import UIKit

public class AAFromFramePresentationDelegate: AATransitionDelegate
{
    private var presentAnimation: AAFromFrameContollerAnimation! = nil
    private var dismissAnimation: AAFromFrameContollerAnimation! = nil
    private var dismissInteraction: AAFromFrameInteractiveTransition! = nil
    private var presentCntrl: AAFromFramePresentationController? = nil
    
    let fromFrame: CGRect
    let duration: TimeInterval
    
    @discardableResult
    public init( presented: UIViewController, presenting: UIViewController, fromFrame: CGRect, duration: TimeInterval, interactive: Bool = true, dimmingView: AAShadeDimming = AAShadeDimming() )
    {
        self.fromFrame = fromFrame
        self.duration = duration
        
        super.init( presented: presented, presenting: presenting )
        presented.view.clipsToBounds = true
        
        presentAnimation = AAFromFrameContollerAnimation( presented: presented, presenting: presenting, delegateId: id, state: .present, duration: duration, fromFrame: fromFrame )
        dismissAnimation = AAFromFrameContollerAnimation( presented: presented, presenting: presenting, delegateId: id, state: .dismiss, duration: duration, fromFrame: fromFrame )
        presentCntrl = AAFromFramePresentationController( dimmingView: dimmingView, presentedViewController: presented, presenting: presenting )
        dismissInteraction = interactive ? AAFromFrameInteractiveTransition( presented: presented, frame: fromFrame ) : nil
    }
    
    func animationController( forDismissed dismissed: UIViewController ) -> UIViewControllerAnimatedTransitioning?
    {
        dismissAnimation
    }
    
    func animationController( forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        presentAnimation
    }
    
    func presentationController( forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController ) -> UIPresentationController?
    {
        presentCntrl
    }
    
    func interactionControllerForDismissal( using animator: UIViewControllerAnimatedTransitioning ) -> UIViewControllerInteractiveTransitioning?
    {
        dismissInteraction?.isInProgress == true ? dismissInteraction : nil
    }
}
