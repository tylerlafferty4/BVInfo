//
//  RSSRealmModel.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 1/30/17.
//  Copyright © 2017 Tyler Lafferty. All rights reserved.
//

import Foundation
import RealmSwift

class RSSRealmModel: Object {
    
    // Specify properties to ignore (Realm won't persist these)
    dynamic var type = ""
    dynamic var title = ""
    dynamic var postDate = ""
    dynamic var postLink = ""
    
//    override static func primaryKey() -> String? {
//        return "type"
//    }
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
}
