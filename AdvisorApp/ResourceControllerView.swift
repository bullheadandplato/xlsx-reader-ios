//
//  ResourceControllerView.swift
//  AdvisorApp
//
//  Created by Osama Bin Omar on 9/25/17.
//  Copyright © 2017 Osama Bin Omar. All rights reserved.
//

import UIKit
import WebKit
class ResourceControllerView: UIViewController, WKUIDelegate,WKNavigationDelegate {
    var webView: WKWebView!
    var alert:  UIAlertView!
    private var url:String!
    public func setUrl(url:String){
        self.url=url
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //show alert that no resource found
        if(!(url != nil && url != "")){
            let miss=UIAlertController(title: "Error",message:"No resource found.",preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .default, handler: { (action) in
              //  self.dismiss(animated: true, completion: nil)
                print("called!")
                self.navigationController?.popViewController(animated: true)
            })
            miss.addAction(action)
            self.present(miss, animated: true, completion: nil)
        }else{
        
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.navigationDelegate=self
        webView.load(myRequest)
        }
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //  show loading indicator
        alert = UIAlertView(title: "Loading Data", message: "Please wait...", delegate: nil, cancelButtonTitle: nil);
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x:50,y: 10,width: 37,height: 37)) as UIActivityIndicatorView
        loadingIndicator.center = self.view.center;
        loadingIndicator.sizeToFit()
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.setValue(loadingIndicator, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        
        alert.show();
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        alert.dismiss(withClickedButtonIndex: 0, animated: true)
    }
}
