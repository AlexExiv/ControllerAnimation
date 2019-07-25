//
//  ModalController.swift
//  Example
//
//  Created by ALEXEY ABDULIN on 25/07/2019.
//  Copyright © 2019 ALEXEY ABDULIN. All rights reserved.
//

import UIKit
import ControllerAnimation

class ModalController: UIViewController, AAPercentModalProtocol
{
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    var modalStride: CGFloat
    {
        return 400.0
    }
    
    var skipViews: [UIView]?
    {
        return [datePickerView]
    }
    
    @IBAction func Close(_ sender: Any)
    {
        dismiss( animated: true, completion: nil )
    }
}
