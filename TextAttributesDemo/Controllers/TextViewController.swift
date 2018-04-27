//
//  DetailViewController.swift
//  TextAttributesDemo
//
//  Created by Irina Dyagileva on 07.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, NSTextStorageDelegate {
    var textView: UITextView!
    
    @IBOutlet weak var lineHeightSwitch: UISwitch!
    @IBOutlet weak var ascenderSwitch: UISwitch!
    @IBOutlet weak var descenderSwitch: UISwitch!
    @IBOutlet weak var capHeightSwitch: UISwitch!
    @IBOutlet weak var xHeightSwitch: UISwitch!
    @IBOutlet weak var lineGapSwitch: UISwitch!
    @IBOutlet weak var boundingRectSwitch: UISwitch!
    @IBOutlet weak var baselineSwitch: UISwitch!
    @IBOutlet weak var meanlineSwitch: UISwitch!
    @IBOutlet weak var usesFontLeadingSwitch: UISwitch!
    
    @IBOutlet weak var textContainerView: UIView!
    @IBOutlet weak var fontMetricsLabel: UILabel!

    var layoutManager: LayoutManager!
    var textStorage: NSTextStorage!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextKitStack()
    }
    
    func setupTextKitStack() {
        // Создаем NSTextStorage
        textStorage = NSTextStorage()
        textStorage.delegate = self;
        
        // Создаем NSLayoutManager и добавляем его в NSTextStorage
        layoutManager = LayoutManager()
        textStorage.addLayoutManager(layoutManager)

        // Создаем NSTextContainer и добавляем его в NSLayoutManager
        let textContainer = NSTextContainer(size: textContainerView.bounds.size)
        textContainer.lineFragmentPadding = 5
        layoutManager.addTextContainer(textContainer)
        
        // Создаем UITextView c заданным NSTextContainer
        textView = UITextView(frame: textContainerView.bounds, textContainer: textContainer)
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        textView.textContainerInset = UIEdgeInsetsMake(30, 30, 30, 30)
        textView.isEditable = false
        textContainerView.addSubview(textView)

        setupDefaultState()
    }
    
    func setupDefaultState() {
        let path = Bundle.main.path(forResource: "Alice", ofType: "txt")
        let text = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        let attributedString = NSAttributedString(string: text, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 50.0)])
        textStorage.setAttributedString(attributedString)
        lineHeightSwitch.isOn = false
        ascenderSwitch.isOn = false
        descenderSwitch.isOn = false
        capHeightSwitch.isOn = false
        xHeightSwitch.isOn = false
        boundingRectSwitch.isOn = false
        baselineSwitch.isOn = false
        meanlineSwitch.isOn = false
        lineGapSwitch.isOn = false
        usesFontLeadingSwitch.isOn = true
        layoutManager.showLineFragment = true
        textRenderingValueChanged()
        
    }
    
    @IBAction func textRenderingValueChanged() {
        layoutManager.showLineHeight = lineHeightSwitch.isOn
        layoutManager.showAscender = ascenderSwitch.isOn
        layoutManager.showDescender = descenderSwitch.isOn
        layoutManager.showCapHeight = capHeightSwitch.isOn
        layoutManager.showXHeight = xHeightSwitch.isOn
        layoutManager.showLineGap = lineGapSwitch.isOn
        layoutManager.showBoundingRect = boundingRectSwitch.isOn
        layoutManager.showBaseline = baselineSwitch.isOn
        layoutManager.showMeanline = meanlineSwitch.isOn
        layoutManager.usesFontLeading = usesFontLeadingSwitch.isOn
        layoutManager.invalidateLayout(forCharacterRange: NSMakeRange(0, textStorage.length), actualCharacterRange: nil)
    }
    
    func updatefontMetricsLabel(_ font: UIFont) {
        let metrics = NSMutableArray()
        metrics.add(NSString(format: "point size %.2f", font.pointSize))
        metrics.add(NSString(format: "line height %.2f", font.lineHeight))
        metrics.add(NSString(format: "ascender %.2f", font.ascender))
        metrics.add(NSString(format: "descender %.2f", font.descender))
        metrics.add(NSString(format: "leading %.2f", font.leading))
        metrics.add(NSString(format: "cap height %.2f", font.capHeight))
        metrics.add(NSString(format: "xHeight %.2f", font.xHeight))
        self.fontMetricsLabel.text = metrics.componentsJoined(by: "\n")
    }
    
    // MARK - NSTextStorageDelegate
    
    func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
        let fontAttribute = textStorage.attribute(NSAttributedStringKey.font, at: editedRange.location, effectiveRange: nil)
        if let font = fontAttribute as? UIFont {
            updatefontMetricsLabel(font)
        }
        
        // redraw selection
        let beginning: UITextPosition = textView.beginningOfDocument
        let start: UITextPosition = textView.position(from: beginning, offset: textView.selectedRange.location)!
        let end: UITextPosition = textView.position(from: start, offset: textView.selectedRange.length)!
        
        textView.selectedRange = NSMakeRange(0, 0)
        textView.selectedTextRange = textView.textRange(from: start, to: end)
    }
}

