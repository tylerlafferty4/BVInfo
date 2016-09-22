//
//  HomeViewControllerCell.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/15/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

class HomeViewControllerCell: UICollectionViewCell {
    
    @IBOutlet var titleLbl : UILabel!
    @IBOutlet var imgView : UIImageView!
    
    override func awakeFromNib() {
        imgView.contentMode = .scaleAspectFill
    }
    
}
