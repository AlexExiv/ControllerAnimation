//
//  File.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 29/12/2018.
//  Copyright © 2018 Appomart. All rights reserved.
//

import UIKit

public class AAScalePresentationDelegate: AATransitionDelegate
{
    func animationController( forDismissed dismissed: UIViewController ) -> UIViewControllerAnimatedTransitioning?
    {
        return AAScaleControllerAnimation( presented: presented, presenting: presenting, delegateId: id, state: .dismiss, duration: 0.8 );
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return AAScaleControllerAnimation( presented: self.presented, presenting: self.presenting, delegateId: id, state: .present, duration: 0.8 );
    }
}
