//
//  IndexView.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/28.
//

import SwiftUI

struct IndexView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var backFirst = false
    @State var toDetail = false
    
    @State var contentHasScrolled = false
    @State var selectedColumn: specialColumn = columns[0]
    
    var body: some View {
        NavigationView {
            ZStack {
                // background
                Image("background3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 360)
                    .blur(radius: 2)
                    .offset(x: 80, y: -240)
                
                ScrollView {
                    scrollDetection
                    // Special Column
                    featured
                        .offset(y: 70)
                    
                    Text("recommend".uppercased())
                        .sectionTitleModifier()
                        .accessibilityAddTraits(.isHeader)
                    
                    // post
                    postsSection
                        .padding()
                        .frame(minHeight: 260)
                        .navigationTitle("")
                        .navigationBarHidden(true)
                        .navigationBarTitleDisplayMode(.inline)
                }
                .overlay(
                    NavigationBar(hasScrolled: $contentHasScrolled)
                )
//                .safeAreaInset(edge: .top, content: {
//                    Color.clear.frame(height: 70)
//                })
            }
        }
    }
        
    
    var postsSection: some View{
        LazyVStack(spacing: 10) {
            ForEach(viewModel.post, id: \.postId) { item in
                postView(postId: item.postId, title: item.title, writer: item.writerName, image: String(item.postId)+"-1", comments: item.comments, photo: "peep-"+item.writerPhoto, text: item.text, time: item.time, imageCount: item.imgCount)
            }
        }
        .onAppear{
            viewModel.fetchPosts()
        }
//        .navigationTitle("")
//        .navigationBarHidden(true)
//        .navigationBarTitleDisplayMode(.inline)
    }
    
    var scrollDetection: some View {
        
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation(.easeInOut) {
                if value < 0 {
                    contentHasScrolled = true
                } else {
                    contentHasScrolled = false
                }
            }
        }
        .frame(height: 0)
    }
    
    var featured: some View {
        TabView{
            ForEach(columns) { column in
                GeometryReader { proxy in
                    FeaturedItem(column: column)
                        .cornerRadius(30)
                        .modifier(OutlineModifier(cornerRadius: 30))
                        .rotation3DEffect(
                            .degrees(proxy.frame(in: .global).minX / -10),
                            axis: (x: 0, y: 1, z: 0), perspective: 1
                        )
                        .shadow(color: Color("Shadow").opacity(0.3), radius: 30, x: 0, y: 30)
                        .blur(radius: abs(proxy.frame(in: .global).minX)/40)
                        .overlay(
                            Image(column.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .offset(x: 100, y: 20)
                                .frame(height: 330)
                                .offset(x: proxy.frame(in: .global).minX/2)
                        )
                        .padding(20)
                        .onTapGesture {
                            selectedColumn = column
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityAddTraits(.isButton)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 460)
        
    }
}

struct postView: View{
    var postId = 3
    var title = "一份《对马岛之魂 奇谭模式》入坑指南/100%奖杯指南"
    var writer = "Kandenzz"
    var image = "-1"
    var comments = 120
    var photo = "peep-58"
    var text = ""
    var time = ""
    var imageCount = 1
    
    
    var body: some View {
        NavigationLink(destination: DetailedView(title: title, time: time, userName: writer, passage: text, photo: photo, comment: comments, imageCount: imageCount, postId: postId)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 15, weight: .medium))
                        .lineLimit(2)
                        .lineSpacing(4)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        
                        
                    HStack {
                        Text(writer)
                            .font(.caption)
                            .foregroundStyle(Color("textGray2"))
                        
                        
                        Spacer()
                        
                        Image(systemName: "bubble.left.fill")
                            .font(.caption)
                            .foregroundStyle(Color("textGray2"))
                        
                        Text(String(comments))
                            .font(.caption)
                            .foregroundStyle(Color("textGray2"))
                            .padding(.leading, -5)
                            
                    }
                    .padding(.top, 1)
                }
                
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 70)
                    .clipped()
                    
            }
        }
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
            .preferredColorScheme(.light)
    }
}


struct ExtractedView: View {
    var foreColor: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .frame(width:358, height: 360)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 40))
    }
}

