//
//  HomeViewControllerCell.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 11/15/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

protocol SwitchCellDelegate {
    func switchValueChanged(on : Bool)
}

class HomeViewControllerCell: UICollectionViewCell {
    
    @IBOutlet var titleLbl : UILabel!
    @IBOutlet var imgView : UIImageView!
    
    override func awakeFromNib() {
        imgView.contentMode = .scaleAspectFill
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 10.0
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    func setupCell() {
        backgroundColor = ThemeManager.colorForKey(colorStr: "mainCell")
        titleLbl.textColor = ThemeManager.colorForKey(colorStr: "mainColor")
        imgView.tintColor = ThemeManager.colorForKey(colorStr: "mainColor")
    }
}

class HomeSwitchCell: UICollectionViewCell {
    
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var themeSwitch: UISwitch!
    var delegate: SwitchCellDelegate!
    
    override func awakeFromNib() {
        layer.cornerRadius = 10
    }
    
    func setupCell() {
        if let theme = UserDefaults.standard.object(forKey: "Theme") as? String {
            if theme == "Theme" {
                themeSwitch.setOn(false, animated: false)
            } else if theme == "DarkTheme" {
                themeSwitch.setOn(true, animated: false)
            }
        }
        backgroundColor = ThemeManager.colorForKey(colorStr: "mainCell")
        titleLbl.textColor = ThemeManager.colorForKey(colorStr: "mainColor")
        themeSwitch.tintColor = ThemeManager.colorForKey(colorStr: "mainColor")
        themeSwitch.onTintColor = ThemeManager.colorForKey(colorStr: "mainColor")
    }
    
    @IBAction func switchChanged(_ sender: AnyObject) {
       self.delegate.switchValueChanged(on: themeSwitch.isOn)
    }
    
}
