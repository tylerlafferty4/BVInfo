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
        self.layer.cornerRadius = 10
        imgView.contentMode = .scaleAspectFill
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
