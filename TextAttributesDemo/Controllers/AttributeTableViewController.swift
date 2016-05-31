//
//  AttributeTableViewController.swift
//  TextAttributesDemo
//
//  Created by Irina Dyagileva on 07.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class AttributeTableViewController: UITableViewController {
    
    var attributes = [Attribute]()
    var completion: AttributeCompletion!
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let attribute = attributes[indexPath.row]
        cell.textLabel?.text = attribute.name
        cell.accessoryType = .None
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark

        attributeValueChanged()
    }
   
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .None

        attributeValueChanged()
    }
        
    func attributeValueChanged(){
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
            let value: Int = selectedIndexPaths.reduce(0, combine: { (res: Int, indexPath: NSIndexPath) -> Int in
                return res | self.attributes[indexPath.row].value
            })
            completion(value)
        } else {
            completion(nil)
        }
    }
}
