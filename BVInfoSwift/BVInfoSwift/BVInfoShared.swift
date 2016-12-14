//
//  BVInfoShared.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 10/20/16.
//  Copyright © 2016 Tyler Lafferty. All rights reserved.
//

import Foundation

class BVInfoShared : NSObject {
    
    static var sharedInstance: BVInfoShared! = BVInfoShared()
    
    var ThemeDict: NSDictionary? = NSDictionary()
}
