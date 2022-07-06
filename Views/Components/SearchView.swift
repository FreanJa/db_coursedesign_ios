//
//  SearchView.swift
//  testMysql
//
//  Created by FreanJa L on 2022/6/9.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var showDetail = false
    @State var selectedPost = posts[0]
    @Namespace var namespace
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                content
                Spacer()
            }
        }
        .searchable(text: $text) {
            ForEach(suggestions) { suggestion in
                Button {
                    text = suggestion.text
                } label: {
                    Text(suggestion.text)
                }
                .searchCompletion(suggestion.text)
            }
        }
    }
    
    var content: some View {
        
        VStack {
            ForEach(Array(results.enumerated()), id: \.offset) { index, post in
                if index != 0 { Divider() }
                ZStack {
                    Button {
                        showDetail = true
                        selectedPost = post
                    } label:  {
                        ListRow(title: post.title, icon: "magnifyingglass")
                    }
                .buttonStyle(.plain)
                }
            }
            
            if results.isEmpty {
                Text("No results found")
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .backgroundStyle(cornerRadius: 30)
        .padding(20)
        .navigationTitle("Search")
        .background(
            Rectangle()
                .fill(.regularMaterial)
                .frame(height: 200)
                .frame(maxHeight: .infinity, alignment: .top)
                .offset(y: -200)
                .blur(radius: 20)
        )
        .background(
            Image("Blob 1").offset(x: -100, y: -200)
                .accessibility(hidden: true)
        )
        .background(
            Image("background2")
                .resizable()
                .scaledToFill()
                .frame(height: 700)
                .offset(x: 120, y: 220)
                .accessibility(hidden: true)
        )
        .sheet(isPresented: $showDetail, content: {
            DetailedView(title: selectedPost.title, time: selectedPost.time, userName: selectedPost.writerName, passage: selectedPost.text, photo: "peep-"+selectedPost.writerPhoto, comment: selectedPost.comments, imageCount: selectedPost.imgCount, postId: selectedPost.postId)
        })
    }
    
    var results: [Post] {
        if text.isEmpty {
            return viewModel.post
//            return posts
        } else {
            return viewModel.post.filter { $0.title.contains(text) }
//            return posts.filter { $0.title.contains(text) }
        }
    }
    
    var suggestions: [Suggestion] {
        if text.isEmpty {
            return suggestionsData
        } else {
            return suggestionsData.filter { $0.text.contains(text) }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
    
struct Suggestion: Identifiable {
    let id = UUID()
    var text: String
}

var suggestionsData = [
    Suggestion(text: "宝可梦"),
    Suggestion(text: "老头环"),
    Suggestion(text: "可达鸭"),
    Suggestion(text: "卡比")
]

