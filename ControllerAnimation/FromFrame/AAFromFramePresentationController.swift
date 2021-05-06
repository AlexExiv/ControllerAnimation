//
//  AAFromFramePresentationController.swift
//  ControllerAnimation
//
//  Created by ALEXEY ABDULIN on 05.05.2021.
//  Copyright © 2021 ALEXEY ABDULIN. All rights reserved.
//

import UIKit

internal class AAFromFramePresentationController: UIPresentationController
{
    private let dimmingView: AAShadeDimming?
    
    init( dimmingView: AAShadeDimming?, presentedViewController: UIViewController, presenting presentingViewController: UIViewController? )
    {
        self.dimmingView = dimmingView
        
        super.init( presentedViewController: presentedViewController, presenting: presentingViewController )
    }

    override func presentationTransitionWillBegin()
    {
        AnimateDimming( show: true )
    }
    
    override func dismissalTransitionWillBegin()
    {
        AnimateDimming( show: false )
    }
    
    override func dismissalTransitionDidEnd( _ completed: Bool )
    {
        dimmingView?.removeFromSuperview()
        if !completed
        {
            presentedViewController.view.setNeedsLayout()
            presentedViewController.view.layoutIfNeeded()
        }
    }
    
    private func AnimateDimming( show: Bool )
    {
        if let dimmingView = dimmingView, let containerView = self.containerView, let coordinator = presentingViewController.transitionCoordinator
        {
            dimmingView.frame = containerView.bounds
            dimmingView.alpha = show ? 0.0 : dimmingView.fOpacity
            containerView.addSubview( dimmingView )
            coordinator.animate( alongsideTransition: { _ in dimmingView.alpha = show ? dimmingView.fOpacity : 0.0 }, completion: nil )
        }
    }
}
