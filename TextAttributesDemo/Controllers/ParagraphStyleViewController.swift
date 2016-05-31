//
//  ParagraphStyleViewController.swift
//  TextAttributesDemo
//
//  Created by Irina Dyagileva on 13.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit
import Foundation

class ParagraphStyleViewController: UITableViewController {
    
    var completion: AttributeCompletion!
    var currentParagraphStyle: NSMutableParagraphStyle!
    
    var paragraphAttributes = [
        "alignment",
        "lineBreakMode",
        "baseWritingDirection",
        "firstLineHeadIndent",
        "headIndent",
        "tailIndent",
        "minimumLineHeight",
        "maximumLineHeight",
        "lineSpacing",
        "paragraphSpacing",
        "paragraphSpacingBefore",
        "lineHeightMultiple",
        "hyphenationFactor"
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentParagraphStyle == nil {
            currentParagraphStyle = NSMutableParagraphStyle()
        }
    }
    
    // MARK: - Table View
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paragraphAttributes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let attribute = paragraphAttributes[indexPath.row]
        
        let cell: UITableViewCell
        switch attribute {
            
        case "firstLineHeadIndent":
            cell = firstLineHeadIndentTableViewCellAtIndexPath(indexPath)
            
        case "headIndent":
            cell = headIndentTableViewCellAtIndexPath(indexPath)
            
        case "tailIndent":
            cell = tailIndentTableViewCellAtIndexPath(indexPath)
            
        case "minimumLineHeight":
            cell = minimumLineHeightTableViewCellAtIndexPath(indexPath)
            
        case "maximumLineHeight":
            cell = maximumLineHeightTableViewCellAtIndexPath(indexPath)
            
        case "lineSpacing":
            cell = lineSpacingTableViewCellAtIndexPath(indexPath)
            
        case "paragraphSpacing":
            cell = paragraphSpacingTableViewCellAtIndexPath(indexPath)
            
        case "paragraphSpacingBefore":
            cell = paragraphSpacingBeforeTableViewCellAtIndexPath(indexPath)
            
        case "lineHeightMultiple":
            cell = lineHeightMultipleTableViewCellAtIndexPath(indexPath)
            
        case "hyphenationFactor":
            cell = hyphenationFactorTableViewCellAtIndexPath(indexPath)
            
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        }
        
        cell.textLabel?.font = UIFont.systemFontOfSize(12.0)
        cell.textLabel?.text = attribute
        cell.textLabel?.backgroundColor = UIColor.clearColor()
 
        return cell
    }
    
    func headIndentTableViewCellAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SpacingAttributeCell", forIndexPath: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.headIndent);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.headIndent = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func firstLineHeadIndentTableViewCellAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SpacingAttributeCell", forIndexPath: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.firstLineHeadIndent);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.firstLineHeadIndent = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func tailIndentTableViewCellAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SpacingAttributeCell", forIndexPath: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.tailIndent);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.tailIndent = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func minimumLineHeightTableViewCellAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LineHeightAttributeCell", forIndexPath: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.minimumLineHeight);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.minimumLineHeight = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func maximumLineHeightTableViewCellAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LineHeightAttributeCell", forIndexPath: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.maximumLineHeight);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.maximumLineHeight = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func lineSpacingTableViewCellAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LineHeightAttributeCell", forIndexPath: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.lineSpacing);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.lineSpacing = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func paragraphSpacingTableViewCellAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LineHeightAttributeCell", forIndexPath: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.paragraphSpacing);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.paragraphSpacing = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func paragraphSpacingBeforeTableViewCellAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LineHeightAttributeCell", forIndexPath: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.paragraphSpacingBefore);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.paragraphSpacingBefore = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func lineHeightMultipleTableViewCellAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MultilierAttributeCell", forIndexPath: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.lineHeightMultiple);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.lineHeightMultiple = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func hyphenationFactorTableViewCellAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HyphenationAttributeCell", forIndexPath: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.hyphenationFactor);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.hyphenationFactor = value as! Float
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
            
        case 0:
            showAlignmentAttributeViewController()
            
        case 1:
            showLineBreakModeAttributeViewController()
            
        case 2:
            showWritingDirectionAttributeViewController()
            
        default:
            return;
        }
    }

    func paragraphStyleDidChange() {
        completion(currentParagraphStyle.copy())
    }
    
    func showAlignmentAttributeViewController() {
        let writingDirection: [Attribute] = [
            Attribute(name: ".Natural", value: NSTextAlignment.Natural.rawValue),
            Attribute(name: ".Left", value: NSTextAlignment.Left.rawValue),
            Attribute(name: ".Right", value: NSTextAlignment.Right.rawValue),
            Attribute(name: ".Center", value: NSTextAlignment.Center.rawValue),
            Attribute(name: ".Justified", value: NSTextAlignment.Justified.rawValue)
        ]
        
        let attributeTableViewController = storyboard?.instantiateViewControllerWithIdentifier("AttributeTableViewController") as! AttributeTableViewController
        attributeTableViewController.attributes = writingDirection
        attributeTableViewController.completion = {
            return { value in
                if let intValue = value as? Int {
                    self.currentParagraphStyle.alignment = NSTextAlignment(rawValue: intValue)!
                }
                self.paragraphStyleDidChange()
            }
            }()
        navigationController?.pushViewController(attributeTableViewController, animated: true)
    }
    
    func showLineBreakModeAttributeViewController() {
        let lineBreakModeAttributes: [Attribute] = [
            Attribute(name: ".ByWordWrapping", value: NSLineBreakMode.ByWordWrapping.rawValue),
            Attribute(name: ".ByCharWrapping", value: NSLineBreakMode.ByCharWrapping.rawValue),
            Attribute(name: ".ByClipping", value: NSLineBreakMode.ByClipping.rawValue),
            Attribute(name: ".ByTruncatingHead", value: NSLineBreakMode.ByTruncatingHead.rawValue),
            Attribute(name: ".ByTruncatingTail", value: NSLineBreakMode.ByTruncatingTail.rawValue),
            Attribute(name: ".ByTruncatingMiddle", value: NSLineBreakMode.ByTruncatingMiddle.rawValue)]
        
        let attributeTableViewController = storyboard?.instantiateViewControllerWithIdentifier("AttributeTableViewController") as! AttributeTableViewController
        attributeTableViewController.attributes = lineBreakModeAttributes
        attributeTableViewController.completion = {
            return { value in
                if let intValue = value as? Int {
                    self.currentParagraphStyle.lineBreakMode = NSLineBreakMode(rawValue: intValue)!
                }
                self.paragraphStyleDidChange()
            }
            }()
        self.navigationController?.pushViewController(attributeTableViewController, animated: true)
    }
    
    func showWritingDirectionAttributeViewController() {
        let writingDirection: [Attribute] = [
            Attribute(name: "NSWritingDirection.Natural", value: NSWritingDirection.Natural.rawValue),
            Attribute(name: "NSWritingDirection.LeftToRight", value: NSWritingDirection.LeftToRight.rawValue),
            Attribute(name: "NSWritingDirection.RightToLeft", value: NSWritingDirection.RightToLeft.rawValue),
            
            Attribute(name: "NSTextWritingDirection.Embedding", value: NSTextWritingDirection.Embedding.rawValue),
            Attribute(name: "NSTextWritingDirection.Override", value: NSTextWritingDirection.Override.rawValue)
        ]
        
        let attributeTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AttributeTableViewController") as! AttributeTableViewController
        attributeTableViewController.attributes = writingDirection
        attributeTableViewController.completion = {
            return { value in
                let intValue = value as! Int
                self.currentParagraphStyle.baseWritingDirection = NSWritingDirection(rawValue: intValue)!
                self.paragraphStyleDidChange()
            }
            }()
        
        self.navigationController?.pushViewController(attributeTableViewController, animated: true)
    }
}
