//
//  PercentModalProtocol.swift
//  Speaker Box Lite
//
//  Created by ALEXEY ABDULIN on 07/01/2019.
//  Copyright © 2019 Appomart. All rights reserved.
//

import UIKit

enum AAPercentModalDirection
{
    case left, right, bottom, top;
}

protocol AAPercentModalProtocol
{
    var modalStride: CGFloat { get };
    var modalStridePercent: CGFloat { get };
    var modalDirection: AAPercentModalDirection { get };
    var modalCornersRadius: CGFloat { get };
    var modalDuration: TimeInterval { get };
}

extension AAPercentModalProtocol
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
}
