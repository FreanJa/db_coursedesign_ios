//
//  Tab.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/28.
//

import Foundation
import SwiftUI

struct TabItem: Identifiable {
    let id = UUID()
    var name: String
    var icon: String
    var color: Color
    var selection: Tab
}

var tabItems = [
    TabItem(name: "首页", icon: "triangle", color: .teal, selection: .index),
    TabItem(name: "探索", icon: "circle", color: .blue, selection: .explore),
    TabItem(name: "消息", icon: "cross", color: .indigo, selection: .message),
    TabItem(name: "我", icon: "app", color: .red, selection: .home)
]

enum Tab: String {
    case index
    case explore
    case message
    case home
    
}
