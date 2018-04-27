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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paragraphAttributes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        }
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12.0)
        cell.textLabel?.text = attribute
        cell.textLabel?.backgroundColor = UIColor.clear
 
        return cell
    }
    
    func headIndentTableViewCellAtIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpacingAttributeCell", for: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.headIndent);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.headIndent = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func firstLineHeadIndentTableViewCellAtIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpacingAttributeCell", for: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.firstLineHeadIndent);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.firstLineHeadIndent = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func tailIndentTableViewCellAtIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpacingAttributeCell", for: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.tailIndent);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.tailIndent = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func minimumLineHeightTableViewCellAtIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LineHeightAttributeCell", for: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.minimumLineHeight);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.minimumLineHeight = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func maximumLineHeightTableViewCellAtIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LineHeightAttributeCell", for: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.maximumLineHeight);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.maximumLineHeight = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func lineSpacingTableViewCellAtIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LineHeightAttributeCell", for: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.lineSpacing);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.lineSpacing = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func paragraphSpacingTableViewCellAtIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LineHeightAttributeCell", for: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.paragraphSpacing);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.paragraphSpacing = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func paragraphSpacingBeforeTableViewCellAtIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LineHeightAttributeCell", for: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.paragraphSpacingBefore);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.paragraphSpacingBefore = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func lineHeightMultipleTableViewCellAtIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MultilierAttributeCell", for: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.lineHeightMultiple);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.lineHeightMultiple = value as! CGFloat
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    func hyphenationFactorTableViewCellAtIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HyphenationAttributeCell", for: indexPath) as! StepperTableViewCell
        cell.stepper.value = Double(currentParagraphStyle.hyphenationFactor);
        cell.completion =  {
            return { value in
                self.currentParagraphStyle.hyphenationFactor = value as! Float
                self.paragraphStyleDidChange()
            }
            }()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        completion(currentParagraphStyle.copy() as AnyObject)
    }
    
    func showAlignmentAttributeViewController() {
        let writingDirection: [Attribute] = [
            Attribute(name: ".Natural", value: NSTextAlignment.natural.rawValue),
            Attribute(name: ".Left", value: NSTextAlignment.left.rawValue),
            Attribute(name: ".Right", value: NSTextAlignment.right.rawValue),
            Attribute(name: ".Center", value: NSTextAlignment.center.rawValue),
            Attribute(name: ".Justified", value: NSTextAlignment.justified.rawValue)
        ]
        
        let attributeTableViewController = storyboard?.instantiateViewController(withIdentifier: "AttributeTableViewController") as! AttributeTableViewController
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
            Attribute(name: ".ByWordWrapping", value: NSLineBreakMode.byWordWrapping.rawValue),
            Attribute(name: ".ByCharWrapping", value: NSLineBreakMode.byCharWrapping.rawValue),
            Attribute(name: ".ByClipping", value: NSLineBreakMode.byClipping.rawValue),
            Attribute(name: ".ByTruncatingHead", value: NSLineBreakMode.byTruncatingHead.rawValue),
            Attribute(name: ".ByTruncatingTail", value: NSLineBreakMode.byTruncatingTail.rawValue),
            Attribute(name: ".ByTruncatingMiddle", value: NSLineBreakMode.byTruncatingMiddle.rawValue)]
        
        let attributeTableViewController = storyboard?.instantiateViewController(withIdentifier: "AttributeTableViewController") as! AttributeTableViewController
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
            Attribute(name: "NSWritingDirection.Natural", value: NSWritingDirection.natural.rawValue),
            Attribute(name: "NSWritingDirection.LeftToRight", value: NSWritingDirection.leftToRight.rawValue),
            Attribute(name: "NSWritingDirection.RightToLeft", value: NSWritingDirection.rightToLeft.rawValue),
            
            Attribute(name: "NSTextWritingDirection.Embedding", value: NSTextWritingDirection.embedding.rawValue),
            Attribute(name: "NSTextWritingDirection.Override", value: NSTextWritingDirection.override.rawValue)
        ]
        
        let attributeTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "AttributeTableViewController") as! AttributeTableViewController
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
