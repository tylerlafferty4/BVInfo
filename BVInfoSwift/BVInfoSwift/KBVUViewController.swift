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
    var player = AVPlayer(url: URL(string: "http://147.92.8.23/kbvu.m3u")!)
    var isPlaying : Bool! = false
    
    var titleTxt : String! = "97.5 KBVU The Edge"
    var webUrl : String! = "https://www.facebook.com/kbvutheedge/?fref=ts"
    
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
        let close = UITapGestureRecognizer(target: self, action: #selector(KBVUViewController.closeWebView))
        closeBtn.addGestureRecognizer(close)
        
        // Back Image View
        backBtn.image = UIImage(named: "arrow-right")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backBtn.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        backBtn.tintColor = UIColor(red: 1.0, green: 234/255, blue: 61/255, alpha: 1.0)
        backBtn.isUserInteractionEnabled = true
        let back = UITapGestureRecognizer(target: self, action: #selector(KBVUViewController.goBack))
        backBtn.addGestureRecognizer(back)
        
        // Forward Image View
        forwardBtn.image = UIImage(named: "arrow-right")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        forwardBtn.tintColor = UIColor(red: 1.0, green: 234/255, blue: 61/255, alpha: 1.0)
        forwardBtn.isUserInteractionEnabled = true
        let forward = UITapGestureRecognizer(target: self, action: #selector(KBVUViewController.goForward))
        forwardBtn.addGestureRecognizer(forward)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Play/Pause Button, Volume
extension KBVUViewController {
    
    @IBAction func volumeChnaged(_ sender: AnyObject) {
        player.volume = volumeSlider.value
    }
    
    @IBAction func playPause(_ sender: AnyObject) {
        if isPlaying == true {
            player.pause()
            playBtn.setImage(UIImage(named: "SongControl_Play"), for: UIControlState())
            isPlaying = false
        }else {
            player.play()
            playBtn.setImage(UIImage(named: "SongControl_Pause"), for: UIControlState())
            isPlaying = true
        }
    }
}

// MARK: - Web View Delegate
extension KBVUViewController : UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activity.isHidden = true
        activity.stopAnimating()
    }
}

// MARK: - Button Naviagation
extension KBVUViewController {
    
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
