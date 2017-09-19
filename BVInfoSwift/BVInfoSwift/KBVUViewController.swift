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
    @IBOutlet var navView : UIView!
    @IBOutlet var statusBarView: UIView!
    
    // Live Stream
    var player = AVPlayer(url: URL(string: "http://147.92.8.23/kbvu.m3u")!)
    var isPlaying : Bool! = false
    
    var titleTxt : String! = "97.5 KBVU The Edge"
    var webUrl : String! = "https://www.facebook.com/kbvutheedge/?fref=ts"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ThemeManager.colorForKey(colorStr: "mainBackground")
        navView.backgroundColor = ThemeManager.colorForKey(colorStr: "navBar")
        audioView.backgroundColor = ThemeManager.colorForKey(colorStr: "navBar")
        statusBarView.backgroundColor = ThemeManager.colorForKey(colorStr: "navBar")
        
        let url = URL (string: webUrl);
        let requestObj = URLRequest(url: url!);
        webView.loadRequest(requestObj);
        
        titleLbl.text = titleTxt
        
        // Close Image View
        closeBtn.image = UIImage(named: "X")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        closeBtn.tintColor = ThemeManager.colorForKey(colorStr: "gold")
        closeBtn.isUserInteractionEnabled = true
        let close = UITapGestureRecognizer(target: self, action: #selector(KBVUViewController.closeWebView))
        closeBtn.addGestureRecognizer(close)
        
        // Back Image View
        backBtn.image = UIImage(named: "arrow-right")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backBtn.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        backBtn.isUserInteractionEnabled = true
        let back = UITapGestureRecognizer(target: self, action: #selector(KBVUViewController.goBack))
        backBtn.addGestureRecognizer(back)
        
        // Forward Image View
        forwardBtn.image = UIImage(named: "arrow-right")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        forwardBtn.isUserInteractionEnabled = true
        let forward = UITapGestureRecognizer(target: self, action: #selector(KBVUViewController.goForward))
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

// MARK: - Play/Pause Button, Volume
extension KBVUViewController {
    
    @IBAction func volumeChnaged(_ sender: AnyObject) {
        player.volume = volumeSlider.value
    }
    
    @IBAction func playPause(_ sender: AnyObject) {
        if isPlaying == true {
            BVInfoShared.logAnswersEvent(title: "Paused KBVU", attributes: [:])
            player.pause()
            playBtn.setImage(UIImage(named: "SongControl_Play"), for: UIControlState())
            isPlaying = false
        }else {
            BVInfoShared.logAnswersEvent(title: "Played KBVU", attributes: [:])
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
        setButtonColors()
    }
}

// MARK: - Button Naviagation
extension KBVUViewController {
    
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
