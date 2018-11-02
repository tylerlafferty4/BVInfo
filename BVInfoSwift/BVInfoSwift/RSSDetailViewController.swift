//
//  RSSDetailViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/2/18.
//  Copyright © 2018 Tyler Lafferty. All rights reserved.
//

import UIKit

class RSSDetailViewController: UIViewController {
    
    // -- Outlets --
    @IBOutlet weak var viewMoreBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    // -- Vars --
    var blogPost: RSSPost!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = blogPost {
            titleLbl.text = post.postTitle
            dateLbl.text = BVInfoShared.formatDate(date: post.postDate)
            descLbl.text = post.postDesc
        }
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewMore" {
            let destVc = segue.destination as! WebsiteViewController
            if let post = blogPost {
                destVc.webUrl = post.postLink
                destVc.titleTxt = post.postTitle
            }
        }
    }
}
