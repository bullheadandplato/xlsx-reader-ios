//
//  ViewController.swift
//  IosGoogling
//
//  Created by Osama Bin Omar on 9/20/17.
//  Copyright © 2017 Osama Bin Omar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        containerView.layoutMargins=UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20);
    }

    @IBOutlet weak var containerView: UIView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

