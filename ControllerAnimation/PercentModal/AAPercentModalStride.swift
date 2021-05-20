//
//  PercentModalStride.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 02/05/2019.
//  Copyright © 2019 Алексей Абдулин. All rights reserved.
//

import UIKit

protocol AAPercentModalStride
{
    var presented: UIViewController! { get };
    
    var stride: CGFloat { get };
    var stridePercent: CGFloat { get };
    var totalStride: CGFloat { get };
    var fullSize: CGFloat { get };
    var skipViews: [UIView]? { get }
    
    var direction: AAPercentModalDirection { get };
    
    var animationDuration: TimeInterval { get };
}

extension AAPercentModalStride
{
    private var modalProtocol: AAPercentModalProtocol?
    {
        if let mp = presented as? AAPercentModalProtocol
        {
            return mp
        }
        
        if let nav = presented as? UINavigationController, let mp = nav.viewControllers.first as? AAPercentModalProtocol
        {
            return mp
        }
        
        return nil
    }
    
    var stride: CGFloat
    {
        modalProtocol?.modalStride ?? 0;
    }
    
    var stridePercent: CGFloat
    {
        modalProtocol?.modalStridePercent ?? 0.9;
    }
    
    var direction: AAPercentModalDirection
    {
        modalProtocol?.modalDirection ?? .bottom;
    }
    
    var fullSize: CGFloat
    {
        let view = presented.view.superview ?? presented.view;
        switch direction
        {
        case .left, .right:
            return view!.frame.size.width;
            
        case .bottom, .top:
            return view!.frame.size.height;
        }
    }
    
    var totalStride: CGFloat
    {
        switch direction
        {
        case .left, .right:
            return stride == 0 ? fullSize*stridePercent : stride;
            
        case .bottom, .top:
            return stride == 0 ? fullSize*stridePercent : stride;
        }
    }
    
    var skipViews: [UIView]?
    {
        modalProtocol?.skipViews
    }
    
    var animationDuration: TimeInterval
    {
        modalProtocol?.modalDuration ?? 0.35;
    }
}
