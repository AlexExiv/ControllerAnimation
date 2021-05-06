//
//  FBlurDimming.swift
//  MetalTest
//
//  Created by ALEXEY ABDULIN on 01/12/2018.
//  Copyright © 2018 ALEXEY ABDULIN. All rights reserved.
//

import UIKit


public class AABlurDimming: AAShadeDimming
{
    private let rBlurEffectView: UIVisualEffectView;
    private let rVibracyEffectView: UIVisualEffectView;
    
    public init( opacity: CGFloat = 1.0, style: UIBlurEffect.Style = .dark )
    {
        let rBlurEffect = UIBlurEffect( style: style )
        rBlurEffectView = UIVisualEffectView( effect: rBlurEffect );
        
        let rVibrancyEffect = UIVibrancyEffect( blurEffect: rBlurEffect );
        rVibracyEffectView = UIVisualEffectView( effect: rVibrancyEffect );
        
        super.init( opacity: opacity, color: UIColor.clear );
        
        addSubview( rBlurEffectView );
        rBlurEffectView.contentView.addSubview( rVibracyEffectView );
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews()
    {
        super.layoutSubviews();
        
        rBlurEffectView.frame = bounds;
        rVibracyEffectView.frame = bounds;
    }
}
