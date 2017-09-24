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
            self.tableView.reloadData()
        }
    }
    public func setTitle(title:String){
        self.detailTitle=title;
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId="HomeDetailCell"
        guard let cell=tableView.dequeueReusableCell(withIdentifier: cellId,for:indexPath) as? DetailTableCell else{
            fatalError("Should be of type Home")
        }
        if data.count==0 {
            return cell
        }
        let name=Array(data.keys)[indexPath.item]
        cell.detailTitle.text=name
        cell.detailDescription.text=data[name]
        tableView.rowHeight=70
        return cell
    
    }
}
