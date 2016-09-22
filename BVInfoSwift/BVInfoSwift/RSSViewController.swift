//
//  RSSViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/16/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit
import iAd

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canDisplayBannerAds = true
        self.title = titleTxt
        self.tableView.backgroundColor = UIColor.lightGray //UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
        let url:URL = URL(string: rssUrl)!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        
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

extension RSSViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "viewpost", sender: self)
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension RSSViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RSSCell
        
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

// MARK: Prepare for segue
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
