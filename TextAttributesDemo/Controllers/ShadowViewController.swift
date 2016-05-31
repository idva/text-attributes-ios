//
//  ShadowViewController.swift
//  TextAttributesDemo
//
//  Created by Irina Dyagileva on 13.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class ShadowViewController: UITableViewController {

    var completion: AttributeCompletion!

    var currentShadow: NSShadow!

    override func viewDidLoad() {
        super.viewDidLoad()
        if currentShadow == nil {
            currentShadow = NSShadow()
        }
    }
    
    @IBAction func shadowOffsetWidthValueChanged(sender: UIStepper) {
        currentShadow.shadowOffset.width += CGFloat(sender.value)
        shadowDidChange()
    }
    
    @IBAction func shadowOffsetHeightValueChanged(sender: UIStepper) {
        currentShadow.shadowOffset.height += CGFloat(sender.value)
        shadowDidChange()
    }

    @IBAction func shadowBlurRadiusValueChanged(sender: UIStepper) {
        currentShadow.shadowBlurRadius += CGFloat(sender.value)
        shadowDidChange()
    }
    
    @IBAction func shadowColorButtonTapped(sender: UIButton) {
        currentShadow.shadowColor = sender.backgroundColor!;
        shadowDidChange()
    }
    
    func shadowDidChange() {
        completion(self.currentShadow.copy())
    }
}
