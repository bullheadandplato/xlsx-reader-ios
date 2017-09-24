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
    private var data:[CellModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title=detailTitle
        DataHandler.loadDetailData(title: detailTitle!) { response2 in
            self.data=response2
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
        return data!.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId="HomeDetailCell"
        guard let cell=tableView.dequeueReusableCell(withIdentifier: cellId,for:indexPath) as? DetailTableCell else{
            fatalError("Should be of type Home")
        }
        if data!.count==0 {
            return cell
        }
        let cellModel=data![indexPath.item]
        cell.detailTitle.text=cellModel.getTitle()
        cell.detailDescription.text=cellModel.getEes()
        tableView.rowHeight=70
        return cell
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index=tableView.indexPathForSelectedRow {
            let selectedTitle=data![index.row]
            guard let detailController=segue.destination as? DetailViewController else{
                fatalError("Not a detail controller")
            }
            detailController.setData(model: selectedTitle)
            
        }
    }
}
