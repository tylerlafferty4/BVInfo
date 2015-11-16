//
//  WebsiteViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/15/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit

class WebsiteViewController: UIViewController {

    @IBOutlet var webView : UIWebView!

    var webUrl : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL (string: webUrl);
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK : Button Naviagation
extension WebsiteViewController {
    
    @IBAction func closeWebView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func goBack(sender: AnyObject) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func goForward(sender: AnyObject) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}
