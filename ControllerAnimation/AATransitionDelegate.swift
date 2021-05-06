//
//  AATransitionDelegate.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 29/12/2018.
//  Copyright © 2018 Appomart. All rights reserved.
//

import UIKit


open class AATransitionDelegate: NSObject, UIViewControllerTransitioningDelegate
{
    static internal var COLLECTION = [AATransitionDelegate]();
    
    static internal func Push( _ transition: AATransitionDelegate )
    {
        COLLECTION.append( transition );
    }
    
    static internal func Remove( _ transitionId: String )
    {
        for i in 0..<COLLECTION.count
        {
            if COLLECTION[i].id == transitionId
            {
                COLLECTION.remove( at: i );
                print( "REMOVE ITEM" );
                break;
            }
        }
    }
    
    public let id = UUID().uuidString;
    public let presented: UIViewController!;
    public let presenting: UIViewController!;
    
    init( presented: UIViewController, presenting: UIViewController )
    {
        self.presented = presented;
        self.presenting = presenting;
        
        super.init();
        
        presented.transitioningDelegate = self;
        //presented.modalPresentationStyle = .custom;
        
        AATransitionDelegate.Push( self );
    }
    
    deinit
    {
        print( "REMOVE TRANSITION DELEGATE" )
    }
}
