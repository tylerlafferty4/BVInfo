//
//  BVInfoShared.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 10/20/16.
//  Copyright © 2016 Tyler Lafferty. All rights reserved.
//

import Foundation
import SystemConfiguration
import Answers
import UIKit

class BVInfoShared : NSObject {
    
    static var sharedInstance: BVInfoShared! = BVInfoShared()
    
    var ThemeDict: NSDictionary? = NSDictionary()
    var googleAdsAppId: String = "ca-app-pub-6103823532663097~9163097561"
    var googleAdsUnitId: String = "ca-app-pub-6103823532663097/1639830764"
    
    class func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    // Animate Table
    class func animateTable(tableView : UITableView) {
        tableView.reloadData()
        if tableView.visibleCells.count > 0 {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            let options = UIViewAnimationOptions()
            UIView.animate(withDuration: 1, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: options, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }
}

// MARK: - Fabric Answers
extension BVInfoShared {
    
    class func logAnswersEvent(title : String, attributes : [String:String]) {
        Answers.logCustomEvent(withName: title, customAttributes: attributes)
    }
}








