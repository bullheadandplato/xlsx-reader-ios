//
//  ViewController.swift
//  IosGoogling
//
//  Created by Osama Bin Omar on 9/20/17.
//  Copyright © 2017 Osama Bin Omar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tableViewController:HomeTableViewController?;
    var homeData=[String()]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DataHandler.loadData(completion:{response in
            self.homeData=response
            DispatchQueue.main.async {
                self.tableViewController!.setData(values: response)

            }
        })
    }
    @IBOutlet weak var containerView: UIView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="tableViewSegue" {
            tableViewController=segue.destination as? HomeTableViewController
        }
    }

}

