//
//  UIViewController+Animation.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 29/12/2018.
//  Copyright © 2018 Appomart. All rights reserved.
//

import UIKit


public extension UIViewController
{
    func PrepareAnimation( segue: UIStoryboardSegue )
    {
        if let id = segue.identifier
        {
            if id.contains( "_ScaleAnim" )
            {
                _ = AAScalePresentationDelegate( presented: segue.destination, presenting: self );
            }
            else if id.contains( "_PercentAnim" )
            {
                _ = AAPercentModalTransitioningDelegate( dimmingView: AAShadeDimming(), presented: segue.destination, presenting: self );
            }
            else if id.contains( "_OpacityAnim" )
            {
                _ = AAOpacityPresentationDelegate( presented: segue.destination, presenting: self );
            }
        }
    }
}
