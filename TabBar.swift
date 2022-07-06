//
//  TabBar.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/28.
//

import SwiftUI

struct TabBar: View {
    @State var color: Color = .teal
    @State var selectedX: CGFloat = 0
    @State var x: [CGFloat] = [0, 0, 0, 0]
    
    @AppStorage("selectedTab") var selectedTab: Tab = .index
    
    
    var body: some View {
        HStack{
            ForEach(Array(tabItems.enumerated()), id: \.offset) { index, tab in
                if index == 0 { Spacer() }
                
                Button {
                    selectedTab = tab.selection
                    withAnimation(.tabSelection) {
                        selectedX = x[index]
                        color = tab.color
                    }
                } label: {
                    VStack(spacing:10){
                        Image(systemName: tab.icon)
//                            .symbolVariant(.fill)
                            .font(.system(size: 20, weight: .bold))
                            .frame(width: 44, height: 29)
                        Text(tab.name).font(.caption)
                            .frame(width: 88)
                            .lineLimit(1)
                    }
                    .overlay(
                        GeometryReader { proxy in
                            let offset = proxy.frame(in: .global).minX
                            Color.clear
                                .preference(key: TabPreferenceKey.self, value: offset)
                                .onPreferenceChange(TabPreferenceKey.self) { value in
                                    x[index] = value
                                    if selectedTab == tab.selection {
                                        selectedX = x[index]
                                    }
                                }
                        }
                    )
                }
                .frame(width: 44)
                .foregroundColor(selectedTab == tab.selection ? .primary : .secondary)
                .blendMode(selectedTab == tab.selection ? .overlay : .normal)
                
                Spacer()
            }
                
        }
//        .padding(.bottom, 16)
        .frame(maxWidth: .infinity, maxHeight: 88)
        .background(.ultraThinMaterial)
        .background(
            Circle()
                .fill(color)
                .offset(x: selectedX, y: -10)
                .frame(width: 88)
//                .frame(height: 90)
                .frame(maxWidth: .infinity, alignment: .leading)
        )
        .overlay(
            Rectangle()
                .frame(width: 28, height: 5)
                .cornerRadius(3)
                .frame(width: 88)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .offset(x: selectedX)
                .blendMode(.overlay)
        )
        .cornerRadius(34)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .offset(y: 0)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
