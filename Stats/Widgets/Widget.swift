//
//  Widget.swift
//  Stats
//
//  Created by Serhiy Mytrovtsiy on 08.07.2019.
//  Copyright © 2019 Serhiy Mytrovtsiy. All rights reserved.
//

import Cocoa

protocol Widget {
    var name: String { get set }
    var shortName: String { get set }
    var activeModule: Observable<Bool> { get set }
    var menus: [NSMenuItem] { get }
    
    func setValue(data: [Double])
    
    func redraw()
    func Init()
}

typealias WidgetType = Float
struct Widgets {
    static let Mini: WidgetType = 0.0
    static let Chart: WidgetType = 1.0
    static let ChartWithValue: WidgetType = 1.1
    
    static let NetworkDots: WidgetType = 2.0
    static let NetworkArrows: WidgetType = 2.1
    static let NetworkText: WidgetType = 2.2
    static let NetworkDotsWithText: WidgetType = 2.3
    static let NetworkArrowsWithText: WidgetType = 2.4
    static let NetworkChart: WidgetType = 2.5
    
    static let BarChart: WidgetType = 3.0
}

struct WidgetSize {
    let width: CGFloat = 32
    let height: CGFloat = NSApplication.shared.mainMenu?.menuBarHeight ?? 22
    let margin: CGFloat = 2
}
let widgetSize = WidgetSize()


class Empty: NSView, Widget {
    var name: String = "Empty"
    var shortName: String = "empty"
    var activeModule: Observable<Bool> = Observable(false)
    var menus: [NSMenuItem] = []

    override init(frame: NSRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: widgetSize.height))
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValue(data: [Double]) {}
    func redraw() {}
    func Init() {}
}
