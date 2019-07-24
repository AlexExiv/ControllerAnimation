//
//  SUFromFramePresentationDelegate.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 28/01/2019.
//  Copyright © 2019 Appomart. All rights reserved.
//

import UIKit


class AAFromFramePresentationDelegate: AATransitionDelegate
{
    func animationController( forDismissed dismissed: UIViewController ) -> UIViewControllerAnimatedTransitioning?
    {
        return AAFromFrameContollerAnimation( presented: presented, presenting: presenting, delegateId: id, state: .dismiss, duration: 0.4 );
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return AAFromFrameContollerAnimation( presented: self.presented, presenting: self.presenting, delegateId: id, state: .present, duration: 0.4 );
    }
}
