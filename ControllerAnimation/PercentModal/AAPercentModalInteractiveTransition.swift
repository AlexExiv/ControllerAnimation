//
//  PercentModalInteractiveTransition.swift
//  MetalTest
//
//  Created by ALEXEY ABDULIN on 30/11/2018.
//  Copyright © 2018 ALEXEY ABDULIN. All rights reserved.
//

import UIKit


internal class AAPercentModalInteractiveTransition: UIPercentDrivenInteractiveTransition, UIGestureRecognizerDelegate, AAPercentModalStride
{
    let presented: UIViewController!;
    private let pan = UIPanGestureRecognizer();
    private var progress = CGFloat( 0 );
    private var anchorProgress = CGFloat( 0 );
    
    private(set) var isInProgress = false;
    var isCanInteraction = true;
    
    private var _skipViews: [UIView]? = nil
    
    init( presented: UIViewController )
    {
        self.presented = presented;
        
        super.init()
        
        pan.addTarget( self, action: #selector( Pan(_:) ) );
        pan.delegate = self;
        presented.view.addGestureRecognizer( pan );
    }
    
    override var completionSpeed: CGFloat
    {
        get
        {
            return 1.0 - (progress - anchorProgress);
        }
        set {}
    }
    
    @objc
    func Pan( _ rPan: UIPanGestureRecognizer )
    {
        let rTranslation = rPan.translation( in: rPan.view?.superview );
        switch direction
        {
        case .left:
            progress = -rTranslation.x/fullSize;
            
        case .right:
            progress = rTranslation.x/fullSize;
            
        case .top:
            progress = -rTranslation.y/fullSize;
            
        case .bottom:
            progress = rTranslation.y/fullSize;
        }
        progress = CGFloat( fminf( fmaxf( Float( progress ), 0.0 ), 1.0 ) )
        
        var isInsideSkip = false
        if _skipViews == nil
        {
            _skipViews = skipViews
        }
        
        if let skipViews = skipViews
        {
            isInsideSkip = skipViews.reduce( false, {
                let p = rPan.location( in: $1 )
                return $0 || $1.point( inside: p, with: nil )
            })
        }
        
        //print( "Progress - \(progress), Translation - \(rTranslation)" );
        if (rPan.state == .changed && !isCanInteraction) || isInsideSkip
        {
            return;
        }

        switch rPan.state
        {
        case .began:
//            bInProgress = true;
//            rPresented.dismiss( animated: true, completion: nil );
            break;

        case .changed:
            if !isInProgress
            {
                isInProgress = true;
                anchorProgress = progress;
                presented.dismiss( animated: true, completion: nil );
            }
            if progress - anchorProgress >= 0
            {
                update( progress - anchorProgress );
            }

        case .cancelled:
            isInProgress = false;
            cancel();

        case .ended:
            isInProgress = false;
            (progress - anchorProgress) > 0.3 ? finish() : cancel();

        default:
            break
        }
    }
    
    func gestureRecognizer( _ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer ) -> Bool
    {
        if let rGesture = gestureRecognizer as? UIPanGestureRecognizer, rGesture == pan
        {
            return true;
        }
        
        return false;
    }
}
