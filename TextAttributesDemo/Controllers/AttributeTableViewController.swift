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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let attribute = attributes[indexPath.row]
        cell.textLabel?.text = attribute.name
        cell.accessoryType = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark

        attributeValueChanged()
    }
   
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none

        attributeValueChanged()
    }
        
    func attributeValueChanged(){
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
            let value: Int = selectedIndexPaths.reduce(0, { (res: Int, indexPath: IndexPath) -> Int in
                return res | self.attributes[indexPath.row].value
            })
            completion(value as AnyObject)
        } else {
            completion(nil)
        }
    }
}
