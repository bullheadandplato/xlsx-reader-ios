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
    @IBOutlet weak var resourceButton: UIButton!
    private var dataModel:CellModel?
    public func setData(model:CellModel){
        self.dataModel=model
    }
        override func viewDidLoad() {
        super.viewDidLoad()
            resourceButton.sizeToFit()
            self.title!=dataModel!.getTitle()
            descriptionLabel.lineBreakMode = .byWordWrapping
            descriptionLabel.numberOfLines  = 0
            descriptionLabel.text=dataModel?.getDescription()
        
    }
    
}
