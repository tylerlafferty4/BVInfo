//
//  AthleticsViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/16/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit

class AthleticsViewController: UIViewController, NSXMLParserDelegate {

    @IBOutlet var tableView : UITableView!
    var parser: NSXMLParser = NSXMLParser()
    var blogPosts : [AthleticsPost] = []
    var postTitle: String = String()
    var postLink: String = String()
    var eName: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Athletics"
        let url:NSURL = NSURL(string: "http://bvuathletics.com/landing/headlines-featured?feed=rss_2.0")!
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
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        let data = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if (!data.isEmpty) {
            if eName == "title" {
                postTitle += data
            } else if eName == "link" {
                postLink += data
            }
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let blogPost: AthleticsPost = AthleticsPost()
            blogPost.postTitle = postTitle
            blogPost.postLink = postLink
            blogPosts.append(blogPost)
        }
    }
}

extension AthleticsViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("viewpost", sender: self)
        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
}

extension AthleticsViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogPosts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        let blogPost: AthleticsPost = blogPosts[indexPath.row]
        cell.textLabel!.text = blogPost.postTitle
        return cell
    }
}

// MARK: Prepare for segue
extension AthleticsViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "viewpost" {
            let blogPost: AthleticsPost = blogPosts[tableView.indexPathForSelectedRow!.row]
            let destVc = segue.destinationViewController as! WebsiteViewController
            destVc.webUrl = blogPost.postLink
            destVc.titleTxt = blogPost.postTitle
        }
    }
}
