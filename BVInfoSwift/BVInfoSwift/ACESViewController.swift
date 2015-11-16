//
//  ACESViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/15/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit

class ACESViewController: UIViewController {

    @IBOutlet var tableView : UITableView!
    var titleTxt : String = ""
    var webUrl : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ACES"
        self.view.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
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
extension ACESViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if indexPath.row == 0 {
            // Cultural
            titleTxt = "Cultural"
            webUrl = "http://bvu.edu/bv/aces/cultural-events.dot"
            self.performSegueWithIdentifier("showWebpage", sender: self)
            
        }else if indexPath.row == 1 {
            // Scholarly
            titleTxt = "Scholarly"
            webUrl = "http://bvu.edu/bv/aces/scholarly-events.dot"
            self.performSegueWithIdentifier("showWebpage", sender: self)
            
        }else if indexPath.row == 2 {
            // Student Life
            titleTxt = "Student Life"
            webUrl = "http://bvu.edu/bv/aces/student-life-events.dot"
            self.performSegueWithIdentifier("showWebpage", sender: self)
            
        }else if indexPath.row == 3 {
            // Check Your Status
            titleTxt = "Check Status"
            webUrl = "http://www2.bvu.edu/departments/academicaffairs/aces/check.asp"
            self.performSegueWithIdentifier("showWebpage", sender: self)
        }
    }
}

// MARK : Table View Datasource
extension ACESViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // Cultural
            let cell = tableView.dequeueReusableCellWithIdentifier("cultural", forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 1 {
            // Scholarly
            let cell = tableView.dequeueReusableCellWithIdentifier("scholarly", forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 2 {
            // Student Life
            let cell = tableView.dequeueReusableCellWithIdentifier("studentLife", forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 3 {
            // Check Status
            let cell = tableView.dequeueReusableCellWithIdentifier("checkStatus", forIndexPath: indexPath)
            return cell
        }
        
        let cell = UITableViewCell()
        return cell
    }
}
