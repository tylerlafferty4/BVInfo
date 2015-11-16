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
    @IBOutlet var activity : UIActivityIndicatorView!
    @IBOutlet var closeBtn : UIImageView!
    @IBOutlet var backBtn : UIImageView!
    @IBOutlet var forwardBtn : UIImageView!
    @IBOutlet var titleLbl : UILabel!
    
    var titleTxt : String! = ""
    var webUrl : String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL (string: webUrl);
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj);
        
        titleLbl.text = titleTxt
        
        // Close Image View
        closeBtn.image = UIImage(named: "X")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        closeBtn.tintColor = UIColor(red: 1.0, green: 234/255, blue: 61/255, alpha: 1.0)
        closeBtn.userInteractionEnabled = true
        let close = UITapGestureRecognizer(target: self, action: Selector("closeWebView"))
        closeBtn.addGestureRecognizer(close)
        
        // Back Image View
        backBtn.image = UIImage(named: "arrow-right")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        backBtn.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        backBtn.tintColor = UIColor(red: 1.0, green: 234/255, blue: 61/255, alpha: 1.0)
        backBtn.userInteractionEnabled = true
        let back = UITapGestureRecognizer(target: self, action: Selector("goBack"))
        backBtn.addGestureRecognizer(back)
        
        // Forward Image View
        forwardBtn.image = UIImage(named: "arrow-right")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        forwardBtn.tintColor = UIColor(red: 1.0, green: 234/255, blue: 61/255, alpha: 1.0)
        forwardBtn.userInteractionEnabled = true
        let forward = UITapGestureRecognizer(target: self, action: Selector("goForward"))
        forwardBtn.addGestureRecognizer(forward)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK : Web View Delegate
extension WebsiteViewController : UIWebViewDelegate {
    func webViewDidStartLoad(webView: UIWebView) {
        activity.hidden = false
        activity.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activity.hidden = true
        activity.stopAnimating()
    }
}

// MARK : Button Naviagation
extension WebsiteViewController {
    
    func closeWebView() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}
