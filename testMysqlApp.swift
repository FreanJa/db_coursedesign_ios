//
//  testMysqlApp.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/18.
//

import SwiftUI

@main
struct testMysqlApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ViewModel())
        }
    }
}
