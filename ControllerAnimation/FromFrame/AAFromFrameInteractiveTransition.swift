//
//  AAFromFrameInteractiveTransition.swift
//  ControllerAnimation
//
//  Created by ALEXEY ABDULIN on 05.05.2021.
//  Copyright © 2021 ALEXEY ABDULIN. All rights reserved.
//

import UIKit

internal class AAFromFrameInteractiveTransition: UIPercentDrivenInteractiveTransition, UIGestureRecognizerDelegate
{
    let presented: UIViewController!
    private let pan = UIPanGestureRecognizer()
    private var progress = CGFloat( 0 )
    private var anchorProgress = CGFloat( 0 )
    private(set) var isInProgress = false

    init( presented: UIViewController, frame: CGRect )
    {
        self.presented = presented
        
        super.init()
        
        pan.addTarget( self, action: #selector( Pan(_:) ) )
        pan.delegate = self
        presented.view.addGestureRecognizer( pan )
    }
    
    override var completionSpeed: CGFloat
    {
        get { 1.0 - (progress - anchorProgress) }
        set {}
    }
    
    @objc
    func Pan( _ pan: UIPanGestureRecognizer )
    {
        let translation = pan.translation( in: nil )
        progress = translation.y/((presented.view.superview?.bounds.size.height ?? 1.0)*0.5)
        progress = CGFloat( fminf( fmaxf( Float( progress ), 0.0 ), 1.0 ) )

        print( "Progress - \(progress), Translation - \(translation)" )

        switch pan.state
        {
        case .began:
            break

        case .changed:
            if !isInProgress
            {
                isInProgress = true
                anchorProgress = progress
                presented.dismiss( animated: true, completion: nil )
            }
            if progress - anchorProgress >= 0
            {
                update( progress - anchorProgress )
            }

        case .cancelled:
            isInProgress = false
            cancel()

        case .ended:
            isInProgress = false
            (progress - anchorProgress) > 0.3 ? finish() : cancel()

        default:
            break
        }
    }
    
    func gestureRecognizer( _ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer ) -> Bool
    {
        if let gesture = gestureRecognizer as? UIPanGestureRecognizer, gesture == pan
        {
            return true
        }
        
        return false
    }
}
