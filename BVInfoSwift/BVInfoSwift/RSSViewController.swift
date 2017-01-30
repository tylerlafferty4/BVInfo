//
//  RSSViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/16/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AudioToolbox

class RSSViewController: UIViewController, XMLParserDelegate {

    @IBOutlet var tableView : UITableView!
    var parser: XMLParser = XMLParser()
    var blogPosts : [RSSPost] = []
    var postTitle: String = String()
    var postLink: String = String()
    var postDate: String = String()
    var eName: String = String()
    var rssUrl : String! = ""
    var titleTxt : String! = ""
    var adMobBannerView = GADBannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAdMobBanner()
        self.title = titleTxt
        self.view.backgroundColor = ThemeManager.colorForKey(colorStr: "mainBackground")
        self.tableView.backgroundColor = ThemeManager.colorForKey(colorStr: "mainBackground")
        let url:URL = URL(string: rssUrl)!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        
        // Check if there is a network connection
        if BVInfoShared.isInternetAvailable() {
            // Go get updated results
            parser.parse()
        } else {
            // Pull results from Realm
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        eName = elementName
        if elementName == "item" {
            postTitle = String()
            postLink = String()
            postDate = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            if eName == "title" {
                postTitle += data
            } else if eName == "link" {
                postLink += data
            } else if eName == "pubDate" {
                postDate += data
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let blogPost: RSSPost = RSSPost()
            blogPost.postTitle = postTitle
            blogPost.postLink = postLink
            blogPost.postDate = postDate
            blogPosts.append(blogPost)
        }
    }
}

// MARK: - Table View Delegate
extension RSSViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "viewpost", sender: self)
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

// MARK: - Table View Datasource
extension RSSViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RSSCell
        cell.setupCell()
        let blogPost: RSSPost = blogPosts[(indexPath as NSIndexPath).row]
        cell.titleLbl.text = blogPost.postTitle
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        let date = dateFormatter.date(from: blogPost.postDate)
        let shortDate = DateFormatter()
        shortDate.dateStyle = .medium
        shortDate.timeStyle = .none
        cell.dateLbl.text = "\(shortDate.string(from: date!))"
        
        return cell
    }
}

// MARK: - Prepare for segue
extension RSSViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "viewpost" {
            let blogPost: RSSPost = blogPosts[(tableView.indexPathForSelectedRow! as NSIndexPath).row]
            let destVc = segue.destination as! WebsiteViewController
            destVc.webUrl = blogPost.postLink
            destVc.titleTxt = blogPost.postTitle
        }
    }
}

// MARK: - Google Ads
extension RSSViewController : GADBannerViewDelegate {
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
        request.testDevices = [kGADSimulatorID]
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
    func adView(_ view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError) {
        hideBanner(adMobBannerView)
    }
}
