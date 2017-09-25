//
//  ViewController.swift
//  IosGoogling
//
//  Created by Osama Bin Omar on 9/20/17.
//  Copyright © 2017 Osama Bin Omar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var tableViewController:HomeTableViewController?;
    var homeData=[String()]
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate=self
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        if homeData.count > 0
        {
            if(searchText.characters.count>0){
                searchBar.showsCancelButton=true
            let filtered = homeData.filter{$0.lowercased().contains(searchText.lowercased()) != false}
            tableViewController?.setData(values: filtered)
            tableViewController?.tableView.reloadData()
            }else{
                tableViewController?.setData(values: homeData)
                tableViewController?.tableView.reloadData()
            }
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton=false
        searchBar.text=""
        searchBar.endEditing(true)
        searchBar.perform(#selector(self.resignFirstResponder), with: nil, afterDelay: 0.1)
        tableViewController?.setData(values: homeData)
        tableViewController?.tableView.reloadData()
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

