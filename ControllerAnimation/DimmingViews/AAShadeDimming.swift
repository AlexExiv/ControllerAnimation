//
//  SUShadeDimming.swift
//  MetalTest
//
//  Created by ALEXEY ABDULIN on 01/12/2018.
//  Copyright © 2018 ALEXEY ABDULIN. All rights reserved.
//

import UIKit


public class AAShadeDimming: UIView
{
    let fOpacity: CGFloat;
    
    public init( opacity: CGFloat = 0.7, color: UIColor = UIColor.black )
    {
        fOpacity = opacity;
        super.init( frame: CGRect() );
        
        backgroundColor = color;
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
