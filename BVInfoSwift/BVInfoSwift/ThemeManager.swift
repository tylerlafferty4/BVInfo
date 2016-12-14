//
//  ThemeManager.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 10/20/16.
//  Copyright © 2016 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

class ThemeManager {
    
    class func setupThemeManager(themeName : String) {
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: themeName, ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        if let dict = myDict {
            // Use your dict here
            BVInfoShared.sharedInstance.ThemeDict = dict
            
        }
    }
    
    class func colorForKey(colorStr : String) -> UIColor {
        return getColorFromString(color: colorStr)
    }
    
    private class func getColorFromString(color : String) -> UIColor {
        let colorString = BVInfoShared.sharedInstance.ThemeDict?.object(forKey: color) as! String
        
        let parts = colorString.components(separatedBy: ",") as [String]
        let r = CGFloat((parts[0] as NSString).doubleValue)
        let g = CGFloat((parts[1] as NSString).doubleValue)
        let b = CGFloat((parts[2] as NSString).doubleValue)
        let a = CGFloat((parts[3] as NSString).doubleValue)
        return createColorFromParts(red: r, green: g, blue: b, alpha: a)
    }
    
    private class func createColorFromParts(red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat) -> UIColor {
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
}
