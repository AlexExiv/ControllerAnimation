//
//  AAPresentedContollerAnimationDelegate.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 17/01/2019.
//  Copyright © 2019 Appomart. All rights reserved.
//

import UIKit


protocol AAPresentedContollerAnimationDelegate
{
    func AnimationDidBegin( animation: AAControllerAnimation );
    func AnimationDidEnd( animation: AAControllerAnimation, completed: Bool );
}

extension AAPresentedContollerAnimationDelegate
{
    func AnimationDidBegin( animation: AAControllerAnimation )
    {
        
    }
    
    func AnimationDidEnd( animation: AAControllerAnimation, completed: Bool )
    {
        
    }
}
