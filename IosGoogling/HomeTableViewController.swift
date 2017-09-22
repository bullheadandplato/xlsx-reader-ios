//
//  HomeTableViewController.swift
//  IosGoogling
//
//  Created by Osama Bin Omar on 9/22/17.
//  Copyright © 2017 Osama Bin Omar. All rights reserved.
//

import UIKit
class HomeTableViewController: UITableViewController {
    private var meals=["Hello"];
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "HomeTableCell"

        guard let cell=tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath) as? HomeTableCell else {
            fatalError("Should be of type love")
        }
        let title=meals[indexPath.item];
        cell.title.text=title
        tableView.rowHeight=70;
        return cell;
    }
    
}
