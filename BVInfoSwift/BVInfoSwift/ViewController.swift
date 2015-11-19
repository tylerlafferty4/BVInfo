//
//  ViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/15/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView : UITableView!
    var webUrl : String = ""
    var titleTxt : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BV Info"
        self.tableView.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.yellowColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.yellowColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0, blue: 128/255, alpha: 1)
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

// MARK: Table View Delegate
extension ViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if indexPath.row == 0 {
            // Sodexo Menu
            webUrl = "https://bvudining.sodexomyway.com/dining-choices/index.html"
            titleTxt = "Sodexo"
            self.performSegueWithIdentifier("showWebpage", sender: self)
        }else if indexPath.row == 1 {
            // ACES
            self.performSegueWithIdentifier("showACES", sender: self)
        }else if indexPath.row == 2 {
            // News

        }else if indexPath.row == 3 {
            // Athletics
            webUrl = "http://bvuathletics.com/landing/headlines-featured?feed=rss_2.0"
            titleTxt = "Athletics"
            self.performSegueWithIdentifier("showRSS", sender: self)

        }else if indexPath.row == 4 {
            // The Tack
            webUrl = "http://www.bvtack.com/feed/"
            titleTxt = "The Tack"
            self.performSegueWithIdentifier("showRSS", sender: self)

        }else if indexPath.row == 5 {
            // CAE
            webUrl = "http://web.bvu.edu/accuweb/"
            titleTxt = "CAE"
            self.performSegueWithIdentifier("showWebpage", sender: self)
        }else if indexPath.row == 6 {
            // Laundry
            webUrl = "https://www.laundryalert.com/cgi-bin/bvu999/LMPage"
            titleTxt = "Laundry"
            self.performSegueWithIdentifier("showWebpage", sender: self)
        }else if indexPath.row == 7 {
            // Academics

        }else if indexPath.row == 8 {
            // KBVU

        }
    }
}

// MARK: Table View Datasource
extension ViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // Sodexo Menu
            let cell = tableView.dequeueReusableCellWithIdentifier("sodexo", forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 1 {
            // ACES
            let cell = tableView.dequeueReusableCellWithIdentifier("aces", forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 2 {
            // News
            let cell = tableView.dequeueReusableCellWithIdentifier("news", forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 3 {
            // Athletics
            let cell = tableView.dequeueReusableCellWithIdentifier("athletics", forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 4 {
            // The Tack
            let cell = tableView.dequeueReusableCellWithIdentifier("tack", forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 5 {
            // CAE
            let cell = tableView.dequeueReusableCellWithIdentifier("cae", forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 6 {
            // Laundry
            let cell = tableView.dequeueReusableCellWithIdentifier("laundry", forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 7 {
            // Academics
            let cell = tableView.dequeueReusableCellWithIdentifier("academics", forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 8 {
            // KBVU
            let cell = tableView.dequeueReusableCellWithIdentifier("kbvu", forIndexPath: indexPath)
            return cell
        }
        
        let cell = UITableViewCell()
        return cell
    }
}

// MARK: Prepare for segue
extension ViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWebpage" {
            let destVc = segue.destinationViewController as! WebsiteViewController
            destVc.titleTxt = titleTxt
            destVc.webUrl = webUrl
        } else if segue.identifier == "showRSS" {
            let destVc = segue.destinationViewController as! RSSViewController
            destVc.titleTxt = titleTxt
            destVc.rssUrl = webUrl
        }
    }
}

