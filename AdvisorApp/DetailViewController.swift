//
//  DetailViewController.swift
//  AdvisorApp
//
//  Created by Osama Bin Omar on 9/24/17.
//  Copyright © 2017 Osama Bin Omar. All rights reserved.
//

import UIKit
class DetailViewController : UIViewController{
    @IBOutlet weak var descriptionLabel: UILabel!
    private var dataModel:CellModel?
    public func setData(model:CellModel){
        self.dataModel=model
    }
        override func viewDidLoad() {
        super.viewDidLoad()
            self.title!=dataModel!.getTitle()
        
    }
    
}
