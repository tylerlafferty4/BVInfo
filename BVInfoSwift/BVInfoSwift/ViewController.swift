//
//  ViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/15/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController {

    @IBOutlet var collectionView : UICollectionView!
    var webUrl : String = ""
    var titleTxt : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canDisplayBannerAds = true
        self.title = "BV Info"
        self.collectionView.backgroundColor = UIColor.lightGray //UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.yellow
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.yellow]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0, blue: 128/255, alpha: 1)
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

// MARK: Table View Delegate
extension ViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true) //deselectRowAtIndexPath(indexPath, animated: false)
        
        if (indexPath as NSIndexPath).row == 0 {
            // Sodexo Menu
            webUrl = "https://bvudining.sodexomyway.com/dining-choices/index.html"
            titleTxt = "Sodexo"
            self.performSegue(withIdentifier: "showWebpage", sender: self)
        }else if (indexPath as NSIndexPath).row == 1 {
            // ACES
            self.performSegue(withIdentifier: "showACES", sender: self)
        }else if (indexPath as NSIndexPath).row == 2 {
            // Events
            webUrl = "https://events.bvu.edu/page/rss/?duration=30days"
            titleTxt = "Events"
            self.performSegue(withIdentifier: "showRSS", sender: self)
            
        }else if (indexPath as NSIndexPath).row == 3 {
            // Athletics
            webUrl = "http://bvuathletics.com/landing/headlines-featured?feed=rss_2.0"
            titleTxt = "Athletics"
            self.performSegue(withIdentifier: "showRSS", sender: self)
            
        }else if (indexPath as NSIndexPath).row == 4 {
            // The Tack
            webUrl = "http://www.bvtack.com/feed/"
            titleTxt = "The Tack"
            self.performSegue(withIdentifier: "showRSS", sender: self)
        }else if (indexPath as NSIndexPath).row == 5 {
            // CAE
            webUrl = "http://web.bvu.edu/accuweb/"
            titleTxt = "CAE"
            self.performSegue(withIdentifier: "showWebpage", sender: self)
        }else if (indexPath as NSIndexPath).row == 6 {
            // Laundry
            webUrl = "https://www.laundryalert.com/cgi-bin/bvu999/LMPage"
            titleTxt = "Laundry"
            self.performSegue(withIdentifier: "showWebpage", sender: self)
        }else if (indexPath as NSIndexPath).row == 7 {
            // Academics
            self.performSegue(withIdentifier: "showAcademics", sender: self)
        }else if (indexPath as NSIndexPath).row == 8 {
            // KBVU
            self.performSegue(withIdentifier: "showKBVU", sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2)-15, height: 125)
    }
}

// MARK: Table View Datasource
extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeViewControllerCell
        
        if (indexPath as NSIndexPath).row == 0 {
            // Sodexo Menu
            cell.titleLbl.text = "Sodexo"
            cell.imgView.image = UIImage(named: "meal")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }else if (indexPath as NSIndexPath).row == 1 {
            // ACES
            cell.titleLbl.text = "ACES"
            cell.imgView.image = UIImage(named: "aces")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }else if (indexPath as NSIndexPath).row == 2 {
            // Events
            cell.titleLbl.text = "Events"
            cell.imgView.image = UIImage(named: "events")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }else if (indexPath as NSIndexPath).row == 3 {
            // Athletics
            cell.titleLbl.text = "Athletics"
            cell.imgView.image = UIImage(named: "beaver")
        }else if (indexPath as NSIndexPath).row == 4 {
            // The Tack
            cell.titleLbl.text = "The Tack"
            cell.imgView.image = UIImage(named: "the-tack")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }else if (indexPath as NSIndexPath).row == 5 {
            // CAE
            cell.titleLbl.text = "CAE"
            cell.imgView.image = UIImage(named: "homework")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }else if (indexPath as NSIndexPath).row == 6 {
            // Laundry
            cell.titleLbl.text = "Laundry"
            cell.imgView.image = UIImage(named: "laundry")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }else if (indexPath as NSIndexPath).row == 7 {
            // Academics
            cell.titleLbl.text = "Academics"
            cell.imgView.image = UIImage(named: "academics")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }else if (indexPath as NSIndexPath).row == 8 {
            // KBVU
            cell.titleLbl.text = "KBVU"
            cell.imgView.image = UIImage(named: "kbvu")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }
        
        return cell
    }
}

// MARK: Prepare for segue
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
        }
    }
}

