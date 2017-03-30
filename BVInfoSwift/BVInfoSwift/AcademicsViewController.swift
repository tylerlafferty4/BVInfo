//
//  AcademicsViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/15/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AudioToolbox

class AcademicsViewController: UIViewController {
    
    @IBOutlet var tableView : UITableView!
    var titleTxt : String = ""
    var webUrl : String = ""
    var adMobBannerView = GADBannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAdMobBanner()
        self.title = "Academics"
        self.tableView.backgroundColor = ThemeManager.colorForKey(colorStr: "mainBackground")
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Table View Delegate
extension AcademicsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if (indexPath as NSIndexPath).row == 0 {
            // Cultural
            titleTxt = "Academic Calendar"
            webUrl = "http://www.bvu.edu/bv/academic-resources/calendar.dot"
            self.performSegue(withIdentifier: "showWebpage", sender: self)
            
        }else if (indexPath as NSIndexPath).row == 1 {
            // Scholarly
            titleTxt = "Majors & Minors"
            webUrl = "http://www.bvu.edu/academics/programs-majors/"
            self.performSegue(withIdentifier: "showWebpage", sender: self)
            
        }else if (indexPath as NSIndexPath).row == 2 {
            // Student Life
            titleTxt = "Canvas"
            webUrl = "https://bvu.instructure.com/login/ldap"
            self.performSegue(withIdentifier: "showWebpage", sender: self)
            
        }
    }
}

// MARK: - Table View Datasource
extension AcademicsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "academicsCell", for: indexPath) as! ACESCell
        cell.setupCell()
        switch (indexPath as NSIndexPath).row {
        case 0:
            cell.titleLbl.text = "Academic Calendar"
        case 1:
            cell.titleLbl.text = "Majors & Minors"
        case 2:
            cell.titleLbl.text = "Canvas"
        default:
            break
        }
        return cell
    }
}

// MARK: - Prepare for segue
extension AcademicsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVc = segue.destination as! WebsiteViewController
        if segue.identifier == "showWebpage" {
            destVc.titleTxt = titleTxt
            destVc.webUrl = webUrl
        }
    }
}


// MARK: - Google Ads
extension AcademicsViewController : GADBannerViewDelegate {
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
