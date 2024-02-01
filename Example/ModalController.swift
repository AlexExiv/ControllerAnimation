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
    @IBOutlet weak var changeLab: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    var modalStride: CGFloat
    {
        containerView.bounds.size.height
    }
    
    var skipViews: [UIView]?
    {
        [datePickerView]
    }
    
    override func viewDidAppear(_ animated: Bool) 
    {
        super.viewDidAppear( animated )
        changeLab.text = "Mark up on the result rectangles cutouts(for speakers, ports...) and related parts slopes on the \"Up\" faces. And on the \"Down\" faces object positions(ports sides, isobaric box, and so on), bulkheads positions. The flip button may be helpful to mirror positions from left to right."
        //RequestUpdatePresentedHeight( animated: animated )
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async {
            self.preferredContentSize = self.containerView.bounds.size
        }
    }
    
    @IBAction func Close(_ sender: Any)
    {
        dismiss( animated: true, completion: nil )
    }
}
