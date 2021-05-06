//
//  AAControllerAnimation.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 29/12/2018.
//  Copyright © 2018 Appomart. All rights reserved.
//

import UIKit


open class AAControllerAnimation: NSObject, UIViewControllerAnimatedTransitioning
{
    public enum State
    {
        case present, dismiss;
    }
    
    private let delegateId: String;
    public let presentState: AAControllerAnimation.State;
    public let duration: TimeInterval;
    
    public private(set) var containerView: UIView! = nil;
    
    public private(set) var presenting: UIViewController! = nil;
    public private(set) var presented: UIViewController! = nil;
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
    open func transitionDuration( using transitionContext: UIViewControllerContextTransitioning? ) -> TimeInterval
    {
        return duration;
    }
    
    open func animateTransition( using transitionContext: UIViewControllerContextTransitioning )
    {
        containerView = transitionContext.containerView;
        presentedDelegate?.AnimationDidBegin( animation: self );
    }
    
    open func animationEnded( _ transitionCompleted: Bool )
    {
        presentedDelegate?.AnimationDidEnd( animation: self, completed: transitionCompleted );
        if( (transitionCompleted && (presentState == .dismiss)) || (!transitionCompleted && (presentState == .present)) )
        {
            AATransitionDelegate.Remove( delegateId );
        }
    }
}
