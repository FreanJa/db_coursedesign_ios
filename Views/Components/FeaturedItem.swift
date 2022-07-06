//
//  FeaturedItem.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/30.
//

import SwiftUI

struct FeaturedItem: View {
    var column: specialColumn
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(column.title.capitalized)
                .font(.system(size: 42, weight: .black, design: .serif))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(column.subtitle.uppercased())
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.secondary)
            Color.gray.frame(width: 300, height: 1)
                .blur(radius: 1)
            Spacer()
            Text(column.text)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: 200, alignment: .leading)
    
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
        .frame(height: 350)
        .background(.ultraThinMaterial)
        .backgroundColor(opacity: 0.5)
    }
}

struct FeaturedItem_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedItem(column: columns[0])
    }
}
