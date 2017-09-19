//
//  WebsiteViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/15/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AudioToolbox

class WebsiteViewController: UIViewController {

    @IBOutlet var webView : UIWebView!
    @IBOutlet var activity : UIActivityIndicatorView!
    @IBOutlet var closeBtn : UIImageView!
    @IBOutlet var backBtn : UIImageView!
    @IBOutlet var forwardBtn : UIImageView!
    @IBOutlet var titleLbl : UILabel!
    @IBOutlet var navView: UIView!
    @IBOutlet var statusBarView: UIView!
    
    var titleTxt : String! = ""
    var webUrl : String! = ""
    var adMobBannerView = GADBannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ThemeManager.colorForKey(colorStr: "mainBackground")
        initAdMobBanner()
        let url = URL (string: webUrl);
        let requestObj = URLRequest(url: url!);
        webView.loadRequest(requestObj);
        
        titleLbl.text = titleTxt
        navView.backgroundColor = ThemeManager.colorForKey(colorStr: "navBar")
        statusBarView.backgroundColor = ThemeManager.colorForKey(colorStr: "navBar")
        
        // Close Image View
        closeBtn.image = UIImage(named: "X")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        closeBtn.tintColor = ThemeManager.colorForKey(colorStr: "gold")
        closeBtn.isUserInteractionEnabled = true
        let close = UITapGestureRecognizer(target: self, action: #selector(WebsiteViewController.closeWebView))
        closeBtn.addGestureRecognizer(close)
        
        // Back Image View
        backBtn.image = UIImage(named: "arrow-right")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backBtn.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        backBtn.isUserInteractionEnabled = true
        let back = UITapGestureRecognizer(target: self, action: #selector(WebsiteViewController.goBack))
        backBtn.addGestureRecognizer(back)
        
        // Forward Image View
        forwardBtn.image = UIImage(named: "arrow-right")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        forwardBtn.isUserInteractionEnabled = true
        let forward = UITapGestureRecognizer(target: self, action: #selector(WebsiteViewController.goForward))
        forwardBtn.addGestureRecognizer(forward)
        
        setButtonColors()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setButtonColors() {
        if webView.canGoBack {
            backBtn.tintColor = ThemeManager.colorForKey(colorStr: "gold")
        } else {
            backBtn.tintColor = UIColor.lightGray
        }
        
        if webView.canGoForward {
            forwardBtn.tintColor = ThemeManager.colorForKey(colorStr: "gold")
        } else {
            forwardBtn.tintColor = UIColor.lightGray
        }
    }
}

// MARK: - Web View Delegate
extension WebsiteViewController : UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        setButtonColors()
        activity.isHidden = true
        activity.stopAnimating()
    }
}

// MARK: - Button Naviagation
extension WebsiteViewController {
    
    @objc func closeWebView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}

// MARK: - Google Ads
extension WebsiteViewController : GADBannerViewDelegate {
    // MARK: -  ADMOB BANNER
    func initAdMobBanner() {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            // iPhone
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
            adMobBannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 320, height: 50)
        } else  {
            // iPad
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 468, height: 60))
            adMobBannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 468, height: 60)
        }
        
        adMobBannerView.adUnitID = BVInfoShared.sharedInstance.googleAdsUnitId
        adMobBannerView.rootViewController = self
        adMobBannerView.delegate = self
        view.addSubview(adMobBannerView)
        
        let request = GADRequest()
//        request.testDevices = [kGADSimulatorID]
        adMobBannerView.load(request)
    }
    
    
    // Hide the banner
    func hideBanner(_ banner: UIView) {
        UIView.beginAnimations("hideBanner", context: nil)
        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        UIView.commitAnimations()
        banner.isHidden = true
    }
    
    // Show the banner
    func showBanner(_ banner: UIView) {
        UIView.beginAnimations("showBanner", context: nil)
        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        UIView.commitAnimations()
        banner.isHidden = false
    }
    
    // AdMob banner available
    func adViewDidReceiveAd(_ view: GADBannerView) {
        showBanner(adMobBannerView)
    }
    
    // NO AdMob banner available
    func adView(_ view: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        hideBanner(adMobBannerView)
    }
}
