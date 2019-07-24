//
//  PercentModalTransitioningDelegate.swift
//  MetalTest
//
//  Created by ALEXEY ABDULIN on 30/11/2018.
//  Copyright © 2018 ALEXEY ABDULIN. All rights reserved.
//

import UIKit


class AAPercentModalTransitioningDelegate: AATransitionDelegate, AAPercentModalStride
{
    private var presentAnimation: AAPercentModalTransitionAnimator! = nil;
    private var dismissAnimation: AAPercentModalTransitionAnimator! = nil;
    private var dismissInteraction: AAPercentModalInteractiveTransition! = nil;
    private var presentCntrl: AAPercentModalPresentationController! = nil;

    var canInteract: Bool
    {
        set
        {
            dismissInteraction.isCanInteraction = newValue;
        }
        get
        {
            return dismissInteraction.isCanInteraction;
        }
    }
    
    var interactionInProgress: Bool
    {
        get
        {
            return dismissInteraction.isInProgress;
        }
    }
    
    init( dimmingView: AAShadeDimming? = nil, presented: UIViewController, presenting: UIViewController)
    {
        var cornerRadius: CGFloat = 0.0;
        if let modal = presented as? AAPercentModalProtocol
        {
            cornerRadius = modal.modalCornersRadius;
        }

        super.init( presented: presented, presenting: presenting );
        
        presented.modalPresentationStyle = .custom;
        presented.view.layer.cornerRadius = cornerRadius;
        presented.view.layer.masksToBounds = true;
        
        presentAnimation = AAPercentModalTransitionAnimator( presented: presented, presenting: presenting, delegateId: id, state: .present );
        dismissAnimation = AAPercentModalTransitionAnimator( presented: presented, presenting: presenting, delegateId: id, state: .dismiss );
        dismissInteraction = AAPercentModalInteractiveTransition( presented: presented );
        presentCntrl = AAPercentModalPresentationController( dimmingView: dimmingView, presentedViewController: presented, presenting: presenting );
    }
    
    //MARK: - UIViewControllerTransitioningDelegate
    func animationController( forDismissed dismissed: UIViewController ) -> UIViewControllerAnimatedTransitioning?
    {
        return dismissAnimation;
    }
    
    func animationController( forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController ) -> UIViewControllerAnimatedTransitioning?
    {
        return presentAnimation;
    }
    
    func presentationController( forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController ) -> UIPresentationController?
    {
        return presentCntrl;
    }
    
    func interactionControllerForDismissal( using animator: UIViewControllerAnimatedTransitioning ) -> UIViewControllerInteractiveTransitioning?
    {
        return dismissInteraction.isInProgress ? dismissInteraction : nil;
    }
}


extension UIViewController
{
    var percentModalDelegate: AAPercentModalTransitioningDelegate?
    {
        get
        {
            if navigationController != nil
            {
                return navigationController?.transitioningDelegate as? AAPercentModalTransitioningDelegate;
            }
            
            return transitioningDelegate as? AAPercentModalTransitioningDelegate;
        }
    }
    
    public var canDismissInteract: Bool
    {
        set
        {
            percentModalDelegate?.canInteract = newValue;
        }
        get
        {
            return percentModalDelegate?.canInteract ?? false;
        }
    }
    
    public var dismissInteractionInProgress: Bool
    {
        get
        {
            return percentModalDelegate?.interactionInProgress ?? false;
        }
    }
    
    public func ProcessInteract( scrollView rScrollView: UIScrollView )
    {
//        print( "contentInset - \(rScrollView.adjustedContentInset)" )
        var fInsetTop: CGFloat = 0.0;
        if #available( iOS 11.0, * )
        {
            fInsetTop = -rScrollView.adjustedContentInset.top;
        }
        else
        {
            fInsetTop = -rScrollView.contentInset.top;
        }
        
        //print( "contentInset - \(fInsetTop)" )
        
        if rScrollView.contentOffset.y < fInsetTop
        {
            canDismissInteract = true;
            rScrollView.contentOffset.y = fInsetTop;
        }
        else if rScrollView.contentOffset.y >= fInsetTop + 0.5
        {
            
            if dismissInteractionInProgress
            {
                rScrollView.contentOffset.y = fInsetTop;
            }
            else
            {
                canDismissInteract = false;
            }
        }
    }
}

extension UITableViewController
{
    public func ProcessInteract()
    {
        ProcessInteract( scrollView: tableView );
    }
}
