//
//  DetailViewController.swift
//  AdvisorApp
//
//  Created by Osama Bin Omar on 9/24/17.
//  Copyright © 2017 Osama Bin Omar. All rights reserved.
//

import UIKit
class DetailViewController : UIViewController{
    private var descriptionText:String?
    private var detailName:String?
    private var detailUrl:String?
    @IBOutlet weak var descriptionLabel: UILabel!
    public func setDetail(detailName:String){
        self.detailName=detailName;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title=detailName
    }
    
}
