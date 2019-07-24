//
//  SUOpacityPresentationDelegate.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 17/01/2019.
//  Copyright © 2019 Appomart. All rights reserved.
//

import UIKit

class AAOpacityPresentationDelegate: AATransitionDelegate
{
    func animationController( forDismissed dismissed: UIViewController ) -> UIViewControllerAnimatedTransitioning?
    {
        return AAOpacityControllerAnimation( presented: presented, presenting: presenting, delegateId: id, state: .dismiss, duration: 0.4 );
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return AAOpacityControllerAnimation( presented: self.presented, presenting: self.presenting, delegateId: id, state: .present, duration: 0.4 );
    }
}
