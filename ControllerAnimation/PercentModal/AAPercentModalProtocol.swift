//
//  PercentModalProtocol.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 07/01/2019.
//  Copyright © 2019 Appomart. All rights reserved.
//

import UIKit

public enum AAPercentModalDirection
{
    case left, right, bottom, top;
}

public protocol AAPercentModalProtocol
{
    var modalStride: CGFloat { get };
    var modalStridePercent: CGFloat { get };
    var modalDirection: AAPercentModalDirection { get };
    var modalCornersRadius: CGFloat { get };
    var modalDuration: TimeInterval { get };
    var skipViews: [UIView]? { get }
}

public extension AAPercentModalProtocol
{
    var modalStride: CGFloat
    {
        return 0.0;
    }
    
    var modalStridePercent: CGFloat
    {
        return 0.9;
    }
    
    var modalDirection: AAPercentModalDirection
    {
        return .bottom;
    }
    
    var modalCornersRadius: CGFloat
    {
        return 0.0;
    }
    
    var modalDuration: TimeInterval
    {
        return 0.35;
    }
    
    var skipViews: [UIView]?
    {
        return nil
    }
}

public extension AAPercentModalProtocol where Self: UIViewController
{
    func RequestUpdatePresentedHeight( animated: Bool = false )
    {
        if animated
        {
            UIView.animate( withDuration: 0.2 ) { [weak self] in self?.presentationController?.containerViewWillLayoutSubviews() }
        }
        else
        {
            presentationController?.containerViewWillLayoutSubviews()
        }
    }
}
