//
//  HomeDetailController.swift
//  IosGoogling
//
//  Created by Osama Bin Omar on 9/24/17.
//  Copyright © 2017 Osama Bin Omar. All rights reserved.
//

import UIKit
class HomeDetailController: UITableViewController {
    private var detailTitle: String?;
    private var data=[String():String()]
    override func viewDidLoad() {
        super.viewDidLoad()
        DataHandler.loadDetailData(title: detailTitle!) { response in
            self.data=response
        }
    }
    public func setTitle(title:String){
        self.detailTitle=title;
    }
}
