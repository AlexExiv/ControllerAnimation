//
//  ViewController.swift
//  Example
//
//  Created by ALEXEY ABDULIN on 24/07/2019.
//  Copyright © 2019 ALEXEY ABDULIN. All rights reserved.
//

import UIKit
import ControllerAnimation

class ViewController: UIViewController
{
    @IBOutlet weak var fromView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        PrepareAnimation( segue: segue )
        
        if let id = segue.identifier
        {
            switch id
            {
            case "FromFrameController":
                AAFromFramePresentationDelegate( presented: segue.destination, presenting: self, fromFrame: fromView.convert( fromView.bounds, to: nil ), duration: 0.4, interactive: true, dimmingView: AAShadeDimming( opacity: 1.0, color: .white ) )
                
            default:
                break
            }
        }
    }
}

