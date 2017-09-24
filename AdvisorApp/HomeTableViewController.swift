//
//  HomeTableViewController.swift
//  IosGoogling
//
//  Created by Osama Bin Omar on 9/22/17.
//  Copyright © 2017 Osama Bin Omar. All rights reserved.
//

import UIKit
class HomeTableViewController: UITableViewController {
    private var meals=[String()];
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
        let image=#imageLiteral(resourceName: "next_icon")
    
        cell.nextIcon.image=image
        cell.nextIcon.tintColor=#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        tableView.rowHeight=70;
        return cell;
    }
    public func setData(values:[String]){
        
        self.meals=values
        self.tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index=tableView.indexPathForSelectedRow {
            let selectedTitle=meals[index.row]
            let detailController=segue.destination as? HomeDetailController
            print("title is: \(selectedTitle)")
            detailController?.setTitle(title: selectedTitle)
        }
    }
}
