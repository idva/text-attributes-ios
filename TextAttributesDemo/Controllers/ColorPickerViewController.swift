//
//  ColorPickerViewController.swift
//  TextAttributesDemo
//
//  Created by Irina Dyagileva on 07.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {
    var completion: AttributeCompletion?
    
    @IBAction func colorButtonDidPress(_ sender: UIButton) {
        completion?(sender.backgroundColor!)
    }
}
