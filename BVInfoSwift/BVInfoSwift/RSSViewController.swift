//
//  RSSViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/16/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit
import iAd

class RSSViewController: UIViewController, NSXMLParserDelegate {

    @IBOutlet var tableView : UITableView!
    var parser: NSXMLParser = NSXMLParser()
    var blogPosts : [RSSPost] = []
    var postTitle: String = String()
    var postLink: String = String()
    var postDate: String = String()
    var eName: String = String()
    var rssUrl : String! = ""
    var titleTxt : String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canDisplayBannerAds = true
        self.title = titleTxt
        self.tableView.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
        let url:NSURL = NSURL(string: rssUrl)!
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.parse()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        eName = elementName
        if elementName == "item" {
            postTitle = String()
            postLink = String()
            postDate = String()
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        let data = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
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
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let blogPost: RSSPost = RSSPost()
            blogPost.postTitle = postTitle
            blogPost.postLink = postLink
            blogPost.postDate = postDate
            blogPosts.append(blogPost)
        }
    }
}

extension RSSViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("viewpost", sender: self)
        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
}

extension RSSViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogPosts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RSSCell
        
        let blogPost: RSSPost = blogPosts[indexPath.row]
        cell.titleLbl.text = blogPost.postTitle
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        let date = dateFormatter.dateFromString(blogPost.postDate)
        let shortDate = NSDateFormatter()
        shortDate.dateStyle = .MediumStyle
        shortDate.timeStyle = .NoStyle
        cell.dateLbl.text = "\(shortDate.stringFromDate(date!))"
        
        return cell
    }
}

// MARK: Prepare for segue
extension RSSViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "viewpost" {
            let blogPost: RSSPost = blogPosts[tableView.indexPathForSelectedRow!.row]
            let destVc = segue.destinationViewController as! WebsiteViewController
            destVc.webUrl = blogPost.postLink
            destVc.titleTxt = blogPost.postTitle
        }
    }
}
