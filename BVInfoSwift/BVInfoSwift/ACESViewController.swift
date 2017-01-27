//
//  ACESViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/15/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit
import iAd

class ACESViewController: UIViewController {

    @IBOutlet var tableView : UITableView!
    var titleTxt : String = ""
    var webUrl : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canDisplayBannerAds = true
        self.title = "ACES"
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
extension ACESViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if (indexPath as NSIndexPath).row == 0 {
            // Cultural
            titleTxt = "Cultural"
            webUrl = "http://bvu.edu/bv/aces/cultural-events.dot"
            self.performSegue(withIdentifier: "showWebpage", sender: self)
            
        }else if (indexPath as NSIndexPath).row == 1 {
            // Scholarly
            titleTxt = "Scholarly"
            webUrl = "http://bvu.edu/bv/aces/scholarly-events.dot"
            self.performSegue(withIdentifier: "showWebpage", sender: self)
            
        }else if (indexPath as NSIndexPath).row == 2 {
            // Student Life
            titleTxt = "Student Life"
            webUrl = "http://bvu.edu/bv/aces/student-life-events.dot"
            self.performSegue(withIdentifier: "showWebpage", sender: self)
            
        }else if (indexPath as NSIndexPath).row == 3 {
            // Check Your Status
            titleTxt = "Check Status"
            webUrl = "http://www2.bvu.edu/departments/academicaffairs/aces/check.asp"
            self.performSegue(withIdentifier: "showWebpage", sender: self)
        }
    }
}

// MARK: - Table View Datasource
extension ACESViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ACESCell", for: indexPath) as! ACESCell
        cell.setupCell()
        switch (indexPath as NSIndexPath).row {
        case 0:
            cell.titleLbl.text = "Cultural"
        case 1:
            cell.titleLbl.text = "Scholarly"
        case 2:
            cell.titleLbl.text = "Student Life"
        case 3:
            cell.titleLbl.text = "Check Your Status"
        default:
            break
        }
        return cell
    }
}

// MARK: - Prepare for Segue
extension ACESViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVc = segue.destination as! WebsiteViewController
        if segue.identifier == "showWebpage" {
            destVc.titleTxt = titleTxt
            destVc.webUrl = webUrl
        }
    }
}
