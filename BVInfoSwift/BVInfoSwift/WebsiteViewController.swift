//
//  WebsiteViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/15/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import iAd
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
        self.canDisplayBannerAds = true
        let url = URL (string: webUrl);
        let requestObj = URLRequest(url: url!);
        webView.loadRequest(requestObj);
        
        titleLbl.text = titleTxt
        
        // Close Image View
        closeBtn.image = UIImage(named: "X")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        closeBtn.tintColor = UIColor(red: 1.0, green: 234/255, blue: 61/255, alpha: 1.0)
        closeBtn.isUserInteractionEnabled = true
        let close = UITapGestureRecognizer(target: self, action: #selector(WebsiteViewController.closeWebView))
        closeBtn.addGestureRecognizer(close)
        
        // Back Image View
        backBtn.image = UIImage(named: "arrow-right")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backBtn.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        backBtn.tintColor = UIColor(red: 1.0, green: 234/255, blue: 61/255, alpha: 1.0)
        backBtn.isUserInteractionEnabled = true
        let back = UITapGestureRecognizer(target: self, action: #selector(WebsiteViewController.goBack))
        backBtn.addGestureRecognizer(back)
        
        // Forward Image View
        forwardBtn.image = UIImage(named: "arrow-right")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        forwardBtn.tintColor = UIColor(red: 1.0, green: 234/255, blue: 61/255, alpha: 1.0)
        forwardBtn.isUserInteractionEnabled = true
        let forward = UITapGestureRecognizer(target: self, action: #selector(WebsiteViewController.goForward))
        forwardBtn.addGestureRecognizer(forward)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK : Web View Delegate
extension WebsiteViewController : UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activity.isHidden = true
        activity.stopAnimating()
    }
}

// MARK : Button Naviagation
extension WebsiteViewController {
    
    func closeWebView() {
        self.dismiss(animated: true, completion: nil)
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
