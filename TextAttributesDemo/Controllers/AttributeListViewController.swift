//
//  MasterViewController.swift
//  TextAttributesDemo
//
//  Created by Irina Dyagileva on 07.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit
import Foundation

struct Attribute {
    var name: String
    var value: Int
}

typealias AttributeCompletion = (AnyObject?) -> ()

class AttributeListViewController: UITableViewController {

    var detailViewController: TextViewController!
    
    var availableAttributes = [
        NSAttributedStringKey.font,
        NSAttributedStringKey.foregroundColor,
        NSAttributedStringKey.backgroundColor,
        NSAttributedStringKey.ligature,
        NSAttributedStringKey.kern,
        NSAttributedStringKey.strikethroughStyle,
        NSAttributedStringKey.strikethroughColor,
        NSAttributedStringKey.underlineStyle,
        NSAttributedStringKey.underlineColor,
        NSAttributedStringKey.strokeColor,
        NSAttributedStringKey.strokeWidth,
        NSAttributedStringKey.shadow,
        NSAttributedStringKey.paragraphStyle,
        NSAttributedStringKey.textEffect,
        NSAttributedStringKey.link,
        NSAttributedStringKey.baselineOffset,
        NSAttributedStringKey.obliqueness,
        NSAttributedStringKey.expansion,
        NSAttributedStringKey.writingDirection,
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let controllers = splitViewController!.viewControllers
        let navigationController = controllers.last as! UINavigationController
        detailViewController = navigationController.topViewController as? TextViewController
    }
    
    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableAttributes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let attribute = availableAttributes[indexPath.row]

        let cell: UITableViewCell
        switch attribute {
            
        case NSAttributedStringKey.kern, NSAttributedStringKey.baselineOffset, NSAttributedStringKey.strokeWidth:
            cell = tableView.dequeueReusableCell(withIdentifier: "FloatAttributeCell", for: indexPath) 
            if let stepperCell = cell as? StepperTableViewCell {
                stepperCell.completion = onComplete(attribute.rawValue)
            }
            
        case NSAttributedStringKey.ligature:
            cell = tableView.dequeueReusableCell(withIdentifier: "LigatureAttributeCell", for: indexPath) 
            if let stepperCell = cell as? StepperTableViewCell {
                stepperCell.completion = onComplete(attribute.rawValue)
            }

        case NSAttributedStringKey.obliqueness, NSAttributedStringKey.expansion:
            cell = tableView.dequeueReusableCell(withIdentifier: "ObliquenessAttributeCell", for: indexPath) 
            if let stepperCell = cell as? StepperTableViewCell {
                stepperCell.completion = onComplete(attribute.rawValue)
            }

        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
        }
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
        cell.textLabel?.text = attribute.rawValue
        cell.textLabel?.backgroundColor = UIColor.clear
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let attribute = availableAttributes[indexPath.row]
        
        switch attribute {
            
        case NSAttributedStringKey.font:
            showFontPickerViewController()
            
        case NSAttributedStringKey.foregroundColor, NSAttributedStringKey.backgroundColor, NSAttributedStringKey.strokeColor, NSAttributedStringKey.underlineColor, NSAttributedStringKey.strikethroughColor:
            let rect = tableView.rectForRow(at: indexPath)
            showColorPickerViewControllerWithAttribute(attribute.rawValue, rect: rect)
            
        case NSAttributedStringKey.strikethroughStyle, NSAttributedStringKey.underlineStyle:
            showUnderlineStyleAttributeViewControllerForAttribute(attribute.rawValue)
            
        case NSAttributedStringKey.shadow:
            showShadowViewController()
            
        case NSAttributedStringKey.paragraphStyle:
            showParagraphStyleViewController()
            
        case NSAttributedStringKey.textEffect:
            let completion:AttributeCompletion = onComplete(attribute.rawValue)
            let value = detailViewController.textStorage.attribute(NSAttributedStringKey.textEffect, at: 0, effectiveRange: nil) as AnyObject?
            if value != nil {
                completion(nil)
            } else {
                completion(NSAttributedString.TextEffectStyle.letterpressStyle as AnyObject?)
            }
            
            
        case NSAttributedStringKey.link:
            let completion:AttributeCompletion = onComplete(attribute.rawValue)
            let range = textRange()
            let value = detailViewController.textStorage.attribute(NSAttributedStringKey.link, at:range.location, effectiveRange: nil) as AnyObject?
            
            if value != nil {
                completion(nil)
            } else {
                completion(URL(string: "http://rambler-co.ru") as AnyObject?)
            }
            
        default:
            return;
        }
    }
    
    // MARK: - Navigation
    
    func showFontPickerViewController() {
        let fontPickerViewController = storyboard?.instantiateViewController(withIdentifier: "FontPickerViewController") as! FontPickerViewController
        let range = textRange()
        let value = detailViewController.textStorage.attribute(NSAttributedStringKey.font, at:range.location, effectiveRange: nil) as? UIFont
        fontPickerViewController.currentFont = value
        fontPickerViewController.completion = onComplete(NSAttributedStringKey.font.rawValue)
        navigationController?.pushViewController(fontPickerViewController, animated: true)
    }
    
    func showColorPickerViewControllerWithAttribute(_ attribute: String, rect: CGRect){
        let colorPickerViewController = storyboard?.instantiateViewController(withIdentifier: "ColorPickerViewController") as! ColorPickerViewController
        colorPickerViewController.completion = onComplete(attribute)
        colorPickerViewController.modalPresentationStyle = .popover

        let popoverController = UIPopoverController(contentViewController: colorPickerViewController)
        DispatchQueue.main.async(execute: { () -> Void in
            popoverController.present(from: rect, in: self.view, permittedArrowDirections: .any, animated: true)
        })
    }
    
    func showUnderlineStyleAttributeViewControllerForAttribute(_ attribute: String){
        let underlineStyleAttributes: [Attribute] = [
            Attribute(name: ".StyleNone", value: NSUnderlineStyle.styleNone.rawValue),
            Attribute(name: ".StyleSingle", value: NSUnderlineStyle.styleSingle.rawValue),
            Attribute(name: ".StyleThick", value: NSUnderlineStyle.styleThick.rawValue),
            Attribute(name: ".StyleDouble", value: NSUnderlineStyle.styleDouble.rawValue),
            
            Attribute(name: ".PatternDot", value: NSUnderlineStyle.patternDot.rawValue),
            Attribute(name: ".PatternDash", value: NSUnderlineStyle.patternDash.rawValue),
            Attribute(name: ".PatternDashDot", value: NSUnderlineStyle.patternDashDot.rawValue),
            Attribute(name: ".PatternDashDotDot", value: NSUnderlineStyle.patternDashDotDot.rawValue),
            
            Attribute(name: ".ByWord", value: NSUnderlineStyle.byWord.rawValue)
        ]
        
        let attributeTableViewController = storyboard?.instantiateViewController(withIdentifier: "AttributeTableViewController") as! AttributeTableViewController
        attributeTableViewController.attributes = underlineStyleAttributes
        attributeTableViewController.completion = onComplete(attribute)
        navigationController?.pushViewController(attributeTableViewController, animated: true)
    }
    
    func showShadowViewController() {
        let shadowViewController =
        storyboard?.instantiateViewController(withIdentifier: "ShadowViewController") as! ShadowViewController
        shadowViewController.completion = onComplete(NSAttributedStringKey.shadow.rawValue)
        let range = textRange()
        let shadow = detailViewController.textStorage.attribute(NSAttributedStringKey.shadow, at: range.location, effectiveRange: nil) as? NSShadow
        shadowViewController.currentShadow = shadow
        navigationController?.pushViewController(shadowViewController, animated: true)
    }
    
    func showParagraphStyleViewController() {
        let paragraphStyleViewController =
        storyboard?.instantiateViewController(withIdentifier: "ParagraphStyleViewController") as! ParagraphStyleViewController
        let range = textRange()
        let paragraphStyle = detailViewController.textStorage.attribute(NSAttributedStringKey.paragraphStyle, at: range.location, effectiveRange: nil) as? NSParagraphStyle
        paragraphStyleViewController.currentParagraphStyle = paragraphStyle?.mutableCopy() as? NSMutableParagraphStyle
        paragraphStyleViewController.completion = onComplete(NSAttributedStringKey.paragraphStyle.rawValue)
        navigationController?.pushViewController(paragraphStyleViewController, animated: true)
    }
    
    // MARK: - Attribute Value

    func textRange() -> NSRange {
        let selectedRange = detailViewController?.textView.selectedRange
        if let range = selectedRange {
            if range.length > 0 {
                return range;
            }
        }
        
        return NSMakeRange(0, detailViewController.textStorage!.length);
    }
    
    func onComplete(_ attribute: String) -> (AttributeCompletion) {
        let range = textRange();
        
        func fnValue (_ value: AnyObject?) {
            if let attributeValue: AnyObject = value {
                detailViewController.textStorage.addAttribute(NSAttributedStringKey(rawValue: attribute), value: attributeValue, range:range)
            } else {
                detailViewController.textStorage.removeAttribute(NSAttributedStringKey(rawValue: attribute), range: range)
            }
        }
        return fnValue;
    }
    
    // MARK: - Actions

    @IBAction func reset(_ sender: AnyObject) {
        detailViewController.setupDefaultState()
        tableView.reloadData()
    }
}

