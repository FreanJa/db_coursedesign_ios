//
//  ExploreView.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/28.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var model: ViewModel
    @State var tags = staticTags
    @State var checked = true
    
    var body: some View {
        ZStack{
            VStack{
                HStack {
                    Text("Explore")
                        .font(.system(size: 24, weight: .bold))
                        .lineLimit(2)
                        .lineSpacing(4)
                    
                    Spacer()
                }
                .padding()
                
                // tags
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack{
                        ForEach(tags.indices, id: \.self) { index in
                            TagComposer(
                                index: index,
                                tagName: tags[index].tag,
                                checked: self.$tags[index].checked
                            )
                        }
                    }
                    .padding(.horizontal, 26)
                }
                
                // game lib
                
                HStack(spacing: 20){
                    GameComposer()
                    GameComposer()
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct TagComposer: View {
    let index: Int
    let tagName: String
    @Binding var checked: Bool

    
    var body: some View {
        Button(action: {
            checked.toggle()
        }, label: {
            Text(tagName)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .tracking(-0.3)
                .foregroundColor(checked ? .white : Color("textGray2"))
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color(checked ? "red1" : "unchecked"))
                .cornerRadius(32)
        })
    }
}

struct GameComposer: View {
    var imageName = "2001-1";
    var title = "迷失";
    var price = "¥ 85";
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 100)
                .clipped()
            
            HStack {
                Text(title)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                Spacer()
                Text(price)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(Color("textGray2"))
            }
            .padding(.horizontal, 4)
            .padding(.top, 8)
            
            HStack {
                gameDetailTag(text: "冒险")
            }
        }
    }
    
    
}

struct gameDetailTag: View {
    var text = "猫";
    var body: some View {
        ZStack{
            Text(text)
                .font(.caption2)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color("unchecked"))
                .cornerRadius(4)
            
        }
    }
}


struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
