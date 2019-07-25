//
//  ViewController.swift
//  Example
//
//  Created by ALEXEY ABDULIN on 24/07/2019.
//  Copyright © 2019 ALEXEY ABDULIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        PrepareAnimation( segue: segue )
    }
}

