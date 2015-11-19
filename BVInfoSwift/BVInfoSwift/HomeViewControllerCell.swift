//
//  HomeViewControllerCell.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/15/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

class HomeViewControllerCell: UITableViewCell {
    
    @IBOutlet var titleLbl : UILabel!
    @IBOutlet var imgView : UIImageView!
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.whiteColor()
        imgView.contentMode = .ScaleAspectFill
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            let mainWidth = UIScreen.mainScreen().bounds.width
            if frame.width > mainWidth - 16 {
                frame.origin.y += 8
                frame.size.height -= 16
                frame.origin.x += 8
                frame.size.width -= 16
            }else {
                if frame.origin.x != 8 {
                    frame.origin.x += 8
                }
            }
            super.frame = frame
        }
    }
}