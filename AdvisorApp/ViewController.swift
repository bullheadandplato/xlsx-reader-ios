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
        //  show loading indicator
        let alert: UIAlertView = UIAlertView(title: "Loading Data", message: "Please wait...", delegate: nil, cancelButtonTitle: nil);
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x:50,y: 10,width: 37,height: 37)) as UIActivityIndicatorView
        loadingIndicator.center = self.view.center;
        loadingIndicator.sizeToFit()
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.setValue(loadingIndicator, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        
        alert.show();
        
        //load data
        DataHandler.loadData(completion:{response in
            self.homeData=response
            DispatchQueue.main.async {
                self.tableViewController!.setData(values: response)
                alert.dismiss(withClickedButtonIndex: 0, animated: true)

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

