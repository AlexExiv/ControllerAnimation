//
//  PercentPresentationController.swift
//  MetalTest
//
//  Created by ALEXEY ABDULIN on 30/11/2018.
//  Copyright © 2018 ALEXEY ABDULIN. All rights reserved.
//

import UIKit



internal class AAPercentModalPresentationController: UIPresentationController, AAPercentModalStride
{
    var presented: UIViewController!
    {
        return presentedViewController;
    }
    
    private let dimmingView: AAShadeDimming?;
    
    
    init( dimmingView: AAShadeDimming?, presentedViewController: UIViewController, presenting presentingViewController: UIViewController? )
    {
        self.dimmingView = dimmingView;
        
        super.init( presentedViewController: presentedViewController, presenting: presentingViewController );
    }

    override var frameOfPresentedViewInContainerView: CGRect
    {
        var frame: CGRect! = nil;
        switch direction
        {
        case .left, .right:
            let x = direction == .left ? 0.0 : (fullSize - totalStride);
            frame = CGRect( x: x, y: 0, width: totalStride, height: presented.view.bounds.size.height );
            
        case .bottom, .top:
            let y = direction == .top ? 0.0 : (fullSize - totalStride);
            frame = CGRect( x: 0, y: y, width: presented.view.bounds.size.width, height: totalStride );
        }

        return frame;
    }
    
    override func containerViewWillLayoutSubviews()
    {
        presentedViewController.view.frame = frameOfPresentedViewInContainerView;
    }
    
    override func presentationTransitionWillBegin()
    {
        if let rView = dimmingView, let rContainerView = self.containerView, let rCoordinator = presentingViewController.transitionCoordinator
        {
            rView.frame = rContainerView.bounds;
            rView.alpha = 0;
            rContainerView.addSubview( rView );
            
            let rTap = UITapGestureRecognizer( target: self, action: #selector( Tap ) );
            rView.addGestureRecognizer( rTap );
            
            rCoordinator.animate( alongsideTransition: { _ in rView.alpha = rView.fOpacity }, completion: nil );
        }
    }
    
    override func dismissalTransitionWillBegin()
    {
        presentingViewController.transitionCoordinator?.animate( alongsideTransition: { _ in self.dimmingView?.alpha = 0.0 }, completion: nil );
    }
    
    override func dismissalTransitionDidEnd( _ completed: Bool )
    {
        if completed
        {
            dimmingView?.removeFromSuperview();
        }
    }

    @objc
    func Tap()
    {
        presentedViewController.dismiss( animated: true, completion: nil );
    }
}

