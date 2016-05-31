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
        textView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        textView.textContainerInset = UIEdgeInsetsMake(30, 30, 30, 30)
        textView.editable = false
        textContainerView.addSubview(textView)

        setupDefaultState()
    }
    
    func setupDefaultState() {
        let path = NSBundle.mainBundle().pathForResource("Alice", ofType: "txt")
        let text = try! String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        let attributedString = NSAttributedString(string: text, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(50.0)])
        textStorage.setAttributedString(attributedString)
        lineHeightSwitch.on = false
        ascenderSwitch.on = false
        descenderSwitch.on = false
        capHeightSwitch.on = false
        xHeightSwitch.on = false
        boundingRectSwitch.on = false
        baselineSwitch.on = false
        meanlineSwitch.on = false
        lineGapSwitch.on = false
        usesFontLeadingSwitch.on = true
        layoutManager.showLineFragment = true
        textRenderingValueChanged()
        
    }
    
    @IBAction func textRenderingValueChanged() {
        layoutManager.showLineHeight = lineHeightSwitch.on
        layoutManager.showAscender = ascenderSwitch.on
        layoutManager.showDescender = descenderSwitch.on
        layoutManager.showCapHeight = capHeightSwitch.on
        layoutManager.showXHeight = xHeightSwitch.on
        layoutManager.showLineGap = lineGapSwitch.on
        layoutManager.showBoundingRect = boundingRectSwitch.on
        layoutManager.showBaseline = baselineSwitch.on
        layoutManager.showMeanline = meanlineSwitch.on
        layoutManager.usesFontLeading = usesFontLeadingSwitch.on
        layoutManager.invalidateLayoutForCharacterRange(NSMakeRange(0, textStorage.length), actualCharacterRange: nil)
    }
    
    func updatefontMetricsLabel(font: UIFont) {
        let metrics = NSMutableArray()
        metrics.addObject(NSString(format: "point size %.2f", font.pointSize))
        metrics.addObject(NSString(format: "line height %.2f", font.lineHeight))
        metrics.addObject(NSString(format: "ascender %.2f", font.ascender))
        metrics.addObject(NSString(format: "descender %.2f", font.descender))
        metrics.addObject(NSString(format: "leading %.2f", font.leading))
        metrics.addObject(NSString(format: "cap height %.2f", font.capHeight))
        metrics.addObject(NSString(format: "xHeight %.2f", font.xHeight))
        self.fontMetricsLabel.text = metrics.componentsJoinedByString("\n")
    }
    
    // MARK - NSTextStorageDelegate
    
    func textStorage(textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
        let fontAttribute = textStorage.attribute(NSFontAttributeName, atIndex: editedRange.location, effectiveRange: nil)
        if let font = fontAttribute as? UIFont {
            updatefontMetricsLabel(font)
        }
        
        // redraw selection
        let beginning: UITextPosition = textView.beginningOfDocument
        let start: UITextPosition = textView.positionFromPosition(beginning, offset: textView.selectedRange.location)!
        let end: UITextPosition = textView.positionFromPosition(start, offset: textView.selectedRange.length)!
        
        textView.selectedRange = NSMakeRange(0, 0)
        textView.selectedTextRange = textView.textRangeFromPosition(start, toPosition: end)
    }
}

