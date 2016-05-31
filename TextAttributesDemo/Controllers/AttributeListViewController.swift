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
        NSFontAttributeName,
        NSForegroundColorAttributeName,
        NSBackgroundColorAttributeName,
        NSLigatureAttributeName,
        NSKernAttributeName,
        NSStrikethroughStyleAttributeName,
        NSStrikethroughColorAttributeName,
        NSUnderlineStyleAttributeName,
        NSUnderlineColorAttributeName,
        NSStrokeColorAttributeName,
        NSStrokeWidthAttributeName,
        NSShadowAttributeName,
        NSParagraphStyleAttributeName,
        NSTextEffectAttributeName,
        NSLinkAttributeName,
        NSBaselineOffsetAttributeName,
        NSObliquenessAttributeName,
        NSExpansionAttributeName,
        NSWritingDirectionAttributeName,
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let controllers = splitViewController!.viewControllers
        let navigationController = controllers.last as! UINavigationController
        detailViewController = navigationController.topViewController as? TextViewController
    }
    
    // MARK: - Table View

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableAttributes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let attribute = availableAttributes[indexPath.row]

        let cell: UITableViewCell
        switch attribute {
            
        case NSKernAttributeName, NSBaselineOffsetAttributeName, NSStrokeWidthAttributeName:
            cell = tableView.dequeueReusableCellWithIdentifier("FloatAttributeCell", forIndexPath: indexPath) 
            if let stepperCell = cell as? StepperTableViewCell {
                stepperCell.completion = onComplete(attribute)
            }
            
        case NSLigatureAttributeName:
            cell = tableView.dequeueReusableCellWithIdentifier("LigatureAttributeCell", forIndexPath: indexPath) 
            if let stepperCell = cell as? StepperTableViewCell {
                stepperCell.completion = onComplete(attribute)
            }

        case NSObliquenessAttributeName, NSExpansionAttributeName:
            cell = tableView.dequeueReusableCellWithIdentifier("ObliquenessAttributeCell", forIndexPath: indexPath) 
            if let stepperCell = cell as? StepperTableViewCell {
                stepperCell.completion = onComplete(attribute)
            }

        default:
            cell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath)
        }
        
        cell.textLabel?.font = UIFont.systemFontOfSize(20.0)
        cell.textLabel?.text = attribute
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let attribute = availableAttributes[indexPath.row]
        
        switch attribute {
            
        case NSFontAttributeName:
            showFontPickerViewController()
            
        case NSForegroundColorAttributeName, NSBackgroundColorAttributeName, NSStrokeColorAttributeName, NSUnderlineColorAttributeName, NSStrikethroughColorAttributeName:
            let rect = tableView.rectForRowAtIndexPath(indexPath)
            showColorPickerViewControllerWithAttribute(attribute, rect: rect)
            
        case NSStrikethroughStyleAttributeName, NSUnderlineStyleAttributeName:
            showUnderlineStyleAttributeViewControllerForAttribute(attribute)
            
        case NSShadowAttributeName:
            showShadowViewController()
            
        case NSParagraphStyleAttributeName:
            showParagraphStyleViewController()
            
        case NSTextEffectAttributeName:
            let completion:AttributeCompletion = onComplete(attribute)
            var value: AnyObject? = detailViewController.textStorage.attribute(NSTextEffectAttributeName, atIndex: 0, effectiveRange: nil)
            value = value != nil ? nil : NSTextEffectLetterpressStyle
            completion(value)
            
        case NSLinkAttributeName:
            let completion:AttributeCompletion = onComplete(attribute)
            let range = textRange()
            var value: AnyObject? = detailViewController.textStorage.attribute(NSLinkAttributeName, atIndex:range.location, effectiveRange: nil)
            value = value != nil ? nil : NSURL(string: "http://rambler-co.ru")
            completion(value)
            
        default:
            return;
        }
    }
    
    // MARK: - Navigation
    
    func showFontPickerViewController() {
        let fontPickerViewController = storyboard?.instantiateViewControllerWithIdentifier("FontPickerViewController") as! FontPickerViewController
        let range = textRange()
        let value = detailViewController.textStorage.attribute(NSFontAttributeName, atIndex:range.location, effectiveRange: nil) as? UIFont
        fontPickerViewController.currentFont = value
        fontPickerViewController.completion = onComplete(NSFontAttributeName)
        navigationController?.pushViewController(fontPickerViewController, animated: true)
    }
    
    func showColorPickerViewControllerWithAttribute(attribute: String, rect: CGRect){
        let colorPickerViewController = storyboard?.instantiateViewControllerWithIdentifier("ColorPickerViewController") as! ColorPickerViewController
        colorPickerViewController.completion = onComplete(attribute)
        colorPickerViewController.modalPresentationStyle = .Popover

        let popoverController = UIPopoverController(contentViewController: colorPickerViewController)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            popoverController.presentPopoverFromRect(rect, inView: self.view, permittedArrowDirections: .Any, animated: true)
        })
    }
    
    func showUnderlineStyleAttributeViewControllerForAttribute(attribute: String){
        let underlineStyleAttributes: [Attribute] = [
            Attribute(name: ".StyleNone", value: NSUnderlineStyle.StyleNone.rawValue),
            Attribute(name: ".StyleSingle", value: NSUnderlineStyle.StyleSingle.rawValue),
            Attribute(name: ".StyleThick", value: NSUnderlineStyle.StyleThick.rawValue),
            Attribute(name: ".StyleDouble", value: NSUnderlineStyle.StyleDouble.rawValue),
            
            Attribute(name: ".PatternDot", value: NSUnderlineStyle.PatternDot.rawValue),
            Attribute(name: ".PatternDash", value: NSUnderlineStyle.PatternDash.rawValue),
            Attribute(name: ".PatternDashDot", value: NSUnderlineStyle.PatternDashDot.rawValue),
            Attribute(name: ".PatternDashDotDot", value: NSUnderlineStyle.PatternDashDotDot.rawValue),
            
            Attribute(name: ".ByWord", value: NSUnderlineStyle.ByWord.rawValue)
        ]
        
        let attributeTableViewController = storyboard?.instantiateViewControllerWithIdentifier("AttributeTableViewController") as! AttributeTableViewController
        attributeTableViewController.attributes = underlineStyleAttributes
        attributeTableViewController.completion = onComplete(attribute)
        navigationController?.pushViewController(attributeTableViewController, animated: true)
    }
    
    func showShadowViewController() {
        let shadowViewController =
        storyboard?.instantiateViewControllerWithIdentifier("ShadowViewController") as! ShadowViewController
        shadowViewController.completion = onComplete(NSShadowAttributeName)
        let range = textRange()
        let shadow = detailViewController.textStorage.attribute(NSShadowAttributeName, atIndex: range.location, effectiveRange: nil) as? NSShadow
        shadowViewController.currentShadow = shadow
        navigationController?.pushViewController(shadowViewController, animated: true)
    }
    
    func showParagraphStyleViewController() {
        let paragraphStyleViewController =
        storyboard?.instantiateViewControllerWithIdentifier("ParagraphStyleViewController") as! ParagraphStyleViewController
        let range = textRange()
        let paragraphStyle = detailViewController.textStorage.attribute(NSParagraphStyleAttributeName, atIndex: range.location, effectiveRange: nil) as? NSParagraphStyle
        paragraphStyleViewController.currentParagraphStyle = paragraphStyle?.mutableCopy() as? NSMutableParagraphStyle
        paragraphStyleViewController.completion = onComplete(NSParagraphStyleAttributeName)
        navigationController?.pushViewController(paragraphStyleViewController, animated: true)
    }
    
    // MARK: - Attribute Value

    func textRange() -> NSRange {
        let range = detailViewController?.textView.selectedRange
        if range?.length > 0 {
            return range!;
        }
        return NSMakeRange(0, detailViewController.textStorage!.length);
    }
    
    func onComplete(attribute: String)(value: AnyObject?) {
        let range = textRange();
        if let attributeValue: AnyObject = value {
            detailViewController.textStorage.addAttribute(attribute, value: attributeValue, range:range)
        } else {
            detailViewController.textStorage.removeAttribute(attribute, range: range)
        }
    }
    
    // MARK: - Actions

    @IBAction func reset(sender: AnyObject) {
        detailViewController.setupDefaultState()
        tableView.reloadData()
    }
}

