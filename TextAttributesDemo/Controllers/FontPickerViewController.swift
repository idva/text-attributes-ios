//
//  FontPickerViewController.swift
//  TextAttributesDemo
//
//  Created by Irina Dyagileva on 07.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit
import Foundation

struct FontFamily {
    let familyName: String
    let fonts: [String]
}

class FontPickerViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var fontSizeLabel: UILabel!

    var currentFont: UIFont?
    var completion: AttributeCompletion?
    var filterString = ""
    
    var fontFamilies = [FontFamily]()
    
    func createFontFamilies() -> [FontFamily] {
        var families = [FontFamily]()

        for fontFamilyName in UIFont.familyNames {
            var filteredFonts = UIFont.fontNames(forFamilyName: fontFamilyName)
            if filterString.count > 0 {
                filteredFonts = filteredFonts.filter{
                     $0.lowercased().range(of: self.filterString.lowercased()) != nil
                }
            }
            
            if filteredFonts.count > 0 {
                families.append(FontFamily(familyName: fontFamilyName, fonts: filteredFonts))
            }
        }
        return families;
    }
    
    override func viewDidLoad() {
        fontFamilies = self.createFontFamilies()
        
        if let currentFont = currentFont {
            slider.value = Float(currentFont.pointSize)
        }
        self.updateUI()
    }

    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fontFamilies.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fontFamily = fontFamilies[section]
        return fontFamily.fonts.count
    }
   
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  fontFamilies[section].familyName
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 

        let fontFamily = fontFamilies[indexPath.section]
        let fontName = fontFamily.fonts[indexPath.row]
            
        cell.textLabel!.text = fontName
        cell.textLabel!.font = UIFont(name: fontName, size: 20.0)
        
        return cell;
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.lightGray;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fontFamily = fontFamilies[indexPath.section]
        let fontName = fontFamily.fonts[indexPath.row]
        currentFont = UIFont(name: fontName, size:CGFloat(slider.value))
        self.updateUI()
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterString = searchText
        fontFamilies = self.createFontFamilies()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    // MARK: - Actions

    @IBAction func sliderValueChanged(_ slider: UISlider) {
        let pointSize = CGFloat(slider.value)
        currentFont = currentFont?.withSize(pointSize)
        self.updateUI()
    }
    
    // MARK: - Update UI 

    func updateUI() {
        fontSizeLabel.text = String(format:"%.1f", slider.value)
        tableView.reloadData()

        completion?(currentFont)
    }
}
