//
//  HomeView.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/28.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ViewModel
    @AppStorage("selectedTab") var selectedTab: Tab = .index
    
    var body: some View {
        ZStack (alignment: .bottom){
            switch selectedTab {
            case .index:
                IndexView()
            case .explore:
                ExploreView()
            case .message:
                MessageView()
            case .home:
                AccountView()
            }
            TabBar()
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
