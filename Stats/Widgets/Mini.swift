//
//  Mini.swift
//  Stats
//
//  Created by Serhiy Mytrovtsiy on 14.06.2019.
//  Copyright © 2019 Serhiy Mytrovtsiy. All rights reserved.
//

import Cocoa

class Mini: NSView, Widget {
    var activeModule: Observable<Bool> = Observable(false)
    var menus: [NSMenuItem] = []
    let defaults = UserDefaults.standard
    
    var size: CGFloat = widgetSize.width
    var valueView: NSTextField = NSTextField()
    var labelView: NSTextField = NSTextField()
    
    var color: Bool = false
    var value: Double = 0
    var name: String = ""
    var shortName: String = "" {
        didSet {
            self.labelView.stringValue = shortName
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.frame.size.width, height: self.frame.size.height)
    }
    
    override init(frame: NSRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: self.size, height: widgetSize.height))
        
        self.wantsLayer = true
        
        let xOffset: CGFloat = 1.0
        
        let labelView = NSTextField(frame: NSMakeRect(xOffset, 13, self.frame.size.width, 7))
        labelView.textColor = NSColor.red
        labelView.isEditable = false
        labelView.isSelectable = false
        labelView.isBezeled = false
        labelView.wantsLayer = true
        labelView.textColor = .labelColor
        labelView.backgroundColor = .controlColor
        labelView.canDrawSubviewsIntoLayer = true
        labelView.alignment = .natural
        labelView.font = NSFont.systemFont(ofSize: 7, weight: .light)
        labelView.stringValue = self.shortName
        labelView.addSubview(NSView())
        
        let valueView = NSTextField(frame: NSMakeRect(xOffset, 3, self.frame.size.width, 10))
        valueView.textColor = NSColor.red
        valueView.isEditable = false
        valueView.isSelectable = false
        valueView.isBezeled = false
        valueView.wantsLayer = true
        valueView.textColor = .labelColor
        valueView.backgroundColor = .controlColor
        valueView.canDrawSubviewsIntoLayer = true
        valueView.alignment = .natural
        valueView.font = NSFont.systemFont(ofSize: 10, weight: .regular)
        valueView.stringValue = ""
        valueView.addSubview(NSView())
        
        self.labelView = labelView
        self.valueView = valueView
        
        self.addSubview(self.labelView)
        self.addSubview(self.valueView)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func Init() {
        self.color = defaults.object(forKey: "\(name)_color") != nil ? defaults.bool(forKey: "\(name)_color") : false
        self.initMenu()
        self.redraw()
    }
    
    func initMenu() {
        let color = NSMenuItem(title: "Color", action: #selector(toggleColor), keyEquivalent: "")
        color.state = self.color ? NSControl.StateValue.on : NSControl.StateValue.off
        color.target = self
        
        self.menus.append(color)
    }
    
    func redraw() {
        self.valueView.textColor = self.value.usageColor(color: self.color)
        self.needsDisplay = true
        setNeedsDisplay(self.frame)
    }
    
    func setValue(data: [Double]) {
        let value: Double = data.first!
        if self.value != value {
            self.value = value
            
            self.valueView.stringValue = "\(Int(Float(value.roundTo(decimalPlaces: 2))! * 100))%"
            self.valueView.textColor = value.usageColor(color: self.color)
        }
    }
    
    @objc func toggleColor(_ sender: NSMenuItem) {
        sender.state = sender.state == NSControl.StateValue.on ? NSControl.StateValue.off : NSControl.StateValue.on
        self.defaults.set(sender.state == NSControl.StateValue.on, forKey: "\(name)_color")
        self.color = sender.state == NSControl.StateValue.on
        self.redraw()
    }
}
