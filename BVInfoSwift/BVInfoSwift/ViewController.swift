//
//  ViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/15/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AudioToolbox
//import TwitterKit

class ViewController: UIViewController {

    @IBOutlet var collectionView : UICollectionView!
    var webUrl : String = ""
    var titleTxt : String = ""
    var adMobBannerView = GADBannerView()
    var shouldShowDesc = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAdMobBanner()
        // Setup the Theme Manager
        if let theme = UserDefaults.standard.object(forKey: "Theme") as? String {
            ThemeManager.setupThemeManager(themeName: theme)
        } else {
            ThemeManager.setupThemeManager(themeName: "Theme")
        }
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.largeTitleTextAttributes =
                [NSAttributedStringKey.foregroundColor: ThemeManager.colorForKey(colorStr: "gold")]
        } else {
            // Fallback on earlier versions
        }
        
        self.title = "BV Info"
        self.view.backgroundColor = ThemeManager.colorForKey(colorStr: "mainBackground")
        self.collectionView.backgroundColor = ThemeManager.colorForKey(colorStr: "mainBackground")
        self.navigationController?.navigationBar.tintColor = ThemeManager.colorForKey(colorStr: "gold")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ThemeManager.colorForKey(colorStr: "gold")]
        self.navigationController?.navigationBar.barTintColor = ThemeManager.colorForKey(colorStr: "navBar")
        collectionView.reloadData()
        
        // TODO: Base this Tweet ID on some data from elsewhere in your app
//        TWTRAPIClient().loadTweet(withID: "631879971628183552") { (tweet, error) in
//            let tweetView = TWTRTweetView(tweet: tweet)
//            if tweetView != nil {
//                tweetView.center = CGPoint(x: self.view.center.x, y: self.topLayoutGuide.length + tweetView.frame.size.height / 2);
//                self.view.addSubview(tweetView)
//            } else {
//                NSLog("Tweet load error: %@", error!.localizedDescription)
//            }
//        }        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Table View Delegate
extension ViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        shouldShowDesc = false
        
        if indexPath.row == 0 {
            // Sodexo Menu
            webUrl = SODEXO.link
            titleTxt = SODEXO.title
            BVInfoShared.logAnswersEvent(title: SODEXO.title, attributes: [:])
            self.performSegue(withIdentifier: SODEXO.segueId, sender: self)
        } else if indexPath.row == 1 {
            // ACES
            BVInfoShared.logAnswersEvent(title: ACES.title, attributes: [:])
            self.performSegue(withIdentifier: ACES.segueId, sender: self)
        } else if indexPath.row == 2 {
            // Events
            webUrl = EVENTS.link
            titleTxt = EVENTS.title
            shouldShowDesc = true
            self.performSegue(withIdentifier: EVENTS.segueId, sender: self)
            
        } else if indexPath.row == 3 {
            // Athletics
            webUrl = ATHLETICS.link
            titleTxt = ATHLETICS.title
            shouldShowDesc = true
            self.performSegue(withIdentifier: ATHLETICS.segueId, sender: self)
            
        } else if indexPath.row == 4 {
            // The Tack
            webUrl = TACK.link
            titleTxt = TACK.title
            shouldShowDesc = true
            self.performSegue(withIdentifier: TACK.segueId, sender: self)
        } else if indexPath.row == 5 {
            // CAE
            webUrl = CAE.link
            titleTxt = CAE.title
            BVInfoShared.logAnswersEvent(title: CAE.title, attributes: [:])
            self.performSegue(withIdentifier: CAE.segueId, sender: self)
        } else if indexPath.row == 6 {
            // Laundry
            webUrl = LAUNDRY.link
            titleTxt = LAUNDRY.title
            BVInfoShared.logAnswersEvent(title: LAUNDRY.title, attributes: [:])
            self.performSegue(withIdentifier: LAUNDRY.segueId, sender: self)
        } else if indexPath.row == 7 {
            // Academics
            BVInfoShared.logAnswersEvent(title: ACADEMICS.title, attributes: [:])
            self.performSegue(withIdentifier: ACADEMICS.segueId, sender: self)
        } else if indexPath.row == 8 {
            // KBVU
            BVInfoShared.logAnswersEvent(title: KBVU.title, attributes: [:])
            self.performSegue(withIdentifier: KBVU.segueId, sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2)-15, height: 125)
    }
}

// MARK: - Table View Datasource
extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeViewControllerCell
        cell.setupCell()
        
        if indexPath.row == 0 {
            // Sodexo Menu
            cell.titleLbl.text = "Sodexo"
            cell.imgView.image = UIImage(named: "meal")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        } else if indexPath.row == 1 {
            // ACES
            cell.titleLbl.text = "ACES"
            cell.imgView.image = UIImage(named: "aces")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        } else if indexPath.row == 2 {
            // Events
            cell.titleLbl.text = "Events"
            cell.imgView.image = UIImage(named: "events")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        } else if indexPath.row == 3 {
            // Athletics
            cell.titleLbl.text = "Athletics"
            cell.imgView.image = UIImage(named: "beaver")
        } else if indexPath.row == 4 {
            // The Tack
            cell.titleLbl.text = "The Tack"
            cell.imgView.image = UIImage(named: "the-tack")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        } else if indexPath.row == 5 {
            // CAE
            cell.titleLbl.text = "CAE"
            cell.imgView.image = UIImage(named: "homework")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        } else if indexPath.row == 6 {
            // Laundry
            cell.titleLbl.text = "Laundry"
            cell.imgView.image = UIImage(named: "laundry")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        } else if indexPath.row == 7 {
            // Academics
            cell.titleLbl.text = "Academics"
            cell.imgView.image = UIImage(named: "academics")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        } else if indexPath.row == 8 {
            // KBVU
            cell.titleLbl.text = "KBVU"
            cell.imgView.image = UIImage(named: "kbvu")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        } else if indexPath.row == 9 {
            // Theme Switch
            let switchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "switchCell", for: indexPath) as! HomeSwitchCell
            switchCell.setupCell()
            switchCell.titleLbl.text = "Dark Theme"
            switchCell.delegate = self
            return switchCell
        }
        
        return cell
    }
}

// MARK: - Switch Cell Delegate
extension ViewController : SwitchCellDelegate {
    func switchValueChanged(on: Bool) {
        if on {
            ThemeManager.setupThemeManager(themeName: "DarkTheme")
            UserDefaults.standard.set("DarkTheme", forKey: "Theme")
            UserDefaults.standard.synchronize()
        } else {
            ThemeManager.setupThemeManager(themeName: "Theme")
            UserDefaults.standard.set("Theme", forKey: "Theme")
            UserDefaults.standard.synchronize()
        }
        resetTheme()
    }
}

// MARK: - Helpers
extension ViewController {
    
    func resetTheme() {
        self.view.backgroundColor = ThemeManager.colorForKey(colorStr: "mainBackground")
        self.navigationController?.navigationBar.barTintColor = ThemeManager.colorForKey(colorStr: "navBar")
        self.collectionView.backgroundColor = ThemeManager.colorForKey(colorStr: "mainBackground")
        self.collectionView.reloadData()
    }
}

// MARK: - Prepare for segue
extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebpage" {
            let destVc = segue.destination as! WebsiteViewController
            destVc.titleTxt = titleTxt
            destVc.webUrl = webUrl
        } else if segue.identifier == "showRSS" {
            let destVc = segue.destination as! RSSViewController
            destVc.titleTxt = titleTxt
            destVc.rssUrl = webUrl
            destVc.shouldShowDescription = shouldShowDesc
        }
    }
}

// MARK: - Google Ads
extension ViewController : GADBannerViewDelegate {
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
        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: (view.frame.size.height - 40) - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
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

