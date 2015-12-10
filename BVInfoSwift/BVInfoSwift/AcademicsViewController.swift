//
//  AcademicsViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/15/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit
import iAd

class AcademicsViewController: UIViewController {
    
    @IBOutlet var tableView : UITableView!
    var titleTxt : String = ""
    var webUrl : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canDisplayBannerAds = true
        self.title = "Academics"
        self.tableView.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVc = segue.destinationViewController as! WebsiteViewController
        if segue.identifier == "showWebpage" {
            destVc.titleTxt = titleTxt
            destVc.webUrl = webUrl
        }
    }
}

// MARK: Table View Delegate
extension AcademicsViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if indexPath.row == 0 {
            // Cultural
            titleTxt = "Academic Calendar"
            webUrl = "http://www.bvu.edu/bv/academic-resources/calendar.dot"
            self.performSegueWithIdentifier("showWebpage", sender: self)
            
        }else if indexPath.row == 1 {
            // Scholarly
            titleTxt = "Majors & Minors"
            webUrl = "http://www.bvu.edu/academics/programs-majors/"
            self.performSegueWithIdentifier("showWebpage", sender: self)
            
        }else if indexPath.row == 2 {
            // Student Life
            titleTxt = "Canvas"
            webUrl = "https://bvu.instructure.com/login/ldap"
            self.performSegueWithIdentifier("showWebpage", sender: self)
            
        }
    }
}

// MARK : Table View Datasource
extension AcademicsViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("academicsCell", forIndexPath: indexPath) as! ACESCell
        
        switch indexPath.row {
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
