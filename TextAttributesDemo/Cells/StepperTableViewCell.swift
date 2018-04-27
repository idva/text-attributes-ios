//
//  StepperTableViewCell.swift
//  TextAttributesDemo
//
//  Created by Irina Dyagileva on 07.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class StepperTableViewCell: UITableViewCell {

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperValueLabel: UILabel!

    var completion: AttributeCompletion?

    @IBAction func stepperValueChanged(_ stepper: UIStepper) {
        stepperValueLabel.text = String(format:"%.1f", stepper.value)
        completion?(stepper.value as AnyObject)
    }
}
