//
//  KBVUViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/22/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit
import iAd

class KBVUViewController: UIViewController {

    @IBOutlet var webView : UIWebView!
    @IBOutlet var activity : UIActivityIndicatorView!
    @IBOutlet var closeBtn : UIImageView!
    @IBOutlet var backBtn : UIImageView!
    @IBOutlet var forwardBtn : UIImageView!
    @IBOutlet var titleLbl : UILabel!
    @IBOutlet var audioView : UIView!
    @IBOutlet var playBtn : UIButton!
    @IBOutlet var volumeSlider : UISlider!
    
    // Live Stream
    var player = AVPlayer(URL: NSURL(string: "http://147.92.8.23/kbvu.m3u")!)
    var isPlaying : Bool! = false
    
    var titleTxt : String! = "97.5 KBVU The Edge"
    var webUrl : String! = "https://www.facebook.com/kbvutheedge/?fref=ts"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canDisplayBannerAds = true
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

// MARK : Play/Pause Button, Volume
extension KBVUViewController {
    
    @IBAction func volumeChnaged(sender: AnyObject) {
        player.volume = volumeSlider.value
    }
    
    @IBAction func playPause(sender: AnyObject) {
        if isPlaying == true {
            player.pause()
            playBtn.setImage(UIImage(named: "SongControl_Play"), forState: UIControlState.Normal)
            isPlaying = false
        }else {
            player.play()
            playBtn.setImage(UIImage(named: "SongControl_Pause"), forState: UIControlState.Normal)
            isPlaying = true
        }
    }
}

// MARK : Web View Delegate
extension KBVUViewController : UIWebViewDelegate {
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
extension KBVUViewController {
    
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
