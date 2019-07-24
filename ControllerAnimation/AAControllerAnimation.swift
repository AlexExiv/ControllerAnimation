//
//  AAControllerAnimation.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 29/12/2018.
//  Copyright © 2018 Appomart. All rights reserved.
//

import UIKit


public class AAControllerAnimation: NSObject, UIViewControllerAnimatedTransitioning
{
    enum State
    {
        case present, dismiss;
    }
    
    private let delegateId: String;
    let presentState: AAControllerAnimation.State;
    let duration: TimeInterval;
    
    private(set) var containerView: UIView! = nil;
    
    private(set) var presenting: UIViewController! = nil;
    private(set) var presented: UIViewController! = nil;
    private var presentedDelegate: AAPresentedContollerAnimationDelegate? = nil;
    
    private var subviews = [UIView]();
    
    init( presented: UIViewController, presenting: UIViewController, delegateId: String, state: AAControllerAnimation.State, duration: TimeInterval )
    {
        self.presented = presented;
        self.presenting = presenting;
        
        self.delegateId = delegateId;
        self.presentState = state;
        self.duration = duration;
        
        if let p = presented as? AAPresentedContollerAnimationDelegate
        {
            presentedDelegate = p;
        }
        else if let navCntrl = presented as? UINavigationController, let p = navCntrl.viewControllers.first as? AAPresentedContollerAnimationDelegate
        {
            presentedDelegate = p;
        }
        
        super.init();
    }
    
    func Add( view: UIView )
    {
        containerView.addSubview( view );
        subviews.append( view );
    }
    
    //MARK: - UIViewControllerAnimatedTransitioning
    public func transitionDuration( using transitionContext: UIViewControllerContextTransitioning? ) -> TimeInterval
    {
        return duration;
    }
    
    public func animateTransition( using transitionContext: UIViewControllerContextTransitioning )
    {
        containerView = transitionContext.containerView;
        presentedDelegate?.AnimationDidBegin( animation: self );
    }
    
    public func animationEnded( _ transitionCompleted: Bool )
    {
        presentedDelegate?.AnimationDidEnd( animation: self, completed: transitionCompleted );
        if( (transitionCompleted && (presentState == .dismiss)) || (!transitionCompleted && (presentState == .present)) )
        {
            AATransitionDelegate.Remove( delegateId );
        }
    }
}
