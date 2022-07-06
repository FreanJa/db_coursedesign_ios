//
//  DetailedView.swift
//  testMysql
//
//  Created by FreanJa L on 2022/6/10.
//

import SwiftUI

struct DetailedView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var isScroll = false
    @State var showComment = false
    
    let title: String
    let time: String
    let userName: String
    let passage: String
    let photo: String
    var comment: Int
    let imageCount: Int
    let postId: Int
    
    init(title:String, time:String, userName:String, passage:String, photo:String, comment:Int, imageCount:Int, postId: Int) {
        let coloredAppearance = UINavigationBarAppearance()
        
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .white
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.blue]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        UINavigationBar.appearance().tintColor = UIColor(Color("LaunchScreenBackground"))
        
        self.title = title
        self.time = time
        self.userName = userName
        self.passage = passage
        self.photo = photo
        self.comment = comment
        self.imageCount = imageCount
        self.postId = postId
    }
    
    var body: some View {
        ZStack{
            // Image
            GeometryReader { geometry in
                TabView {
                    ForEach(1...imageCount, id: \.self) { index in
                        Image(String(postId)+"-"+String(index))
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: 300)
                            .clipped()
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .animation(.spring(), value: isScroll)
                .offset(y: isScroll ? -520 : -330)
            }
            // body
            PassageBody(isScroll: $isScroll, title: title, userName: userName, time: time, photo: photo, passage: passage)
            
        }
//        .background(Color("lightGrey2"))
        .toolbar {
            ToolbarItem(id: "com", placement: .navigationBarTrailing) {
                Button(action: {
                    showComment.toggle()
                    viewModel.fetchComments(parameters: ["postId": postId]) { isSuccess in
                        DispatchQueue.main.async {
                            if isSuccess {
                                if !viewModel.info[0].error {
                                    print("get comments: ")
                                }
                            }
                            else {
                                print("no comments")
                            }
                        }
                    }
                    
                }, label: {
                    Image(systemName: "bubble.left")
                })
                .sheet(isPresented: $showComment, content: {
                    CommentView(commentsNum: comment, title: title, userName: userName, time: time, postId: postId)
                })
                    
            }
        }
    }
    
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(title: "Is Red Meat Back On The Menu?", time: "April 9, 2020, 13:30 PM", userName: "Frank Gomez", passage: "A controversial study says cutting down on sausages, mince, steak and all other forms of red or processed meat is a waste of time for most people.\n\nThe report - which disagrees with most major organisations on the planet - says the evidence is weak and any risk to people's health is small.\n\nSome experts have praised the \"rigorous\" assessment.\n\nBut others say \"the public could be put at risk\" by such \"dangerously misguided\" research.\n\nWhat counts as red or processed meat?\n\nRed meat includes beef, lamb, pork, veal and venison - chicken, duck and game birds do not count.\n\nProcessed meat has been modified to either extend its shelf life or change the taste - and the main methods are smoking, curing, or adding salt or preservatives.\n\nPure mince does not count as processed, but bacon, sausages, hot dogs, salami, corned beef, pates and ham all do.\n\n\nA controversial study says cutting down on sausages, mince, steak and all other forms of red or processed meat is a waste of time for most people.\n\nThe report - which disagrees with most major organisations on the planet - says the evidence is weak and any risk to people's health is small.\n\nSome experts have praised the \"rigorous\" assessment.\n\nBut others say \"the public could be put at risk\" by such \"dangerously misguided\" research.\n\nWhat counts as red or processed meat?\n\nRed meat includes beef, lamb, pork, veal and venison - chicken, duck and game birds do not count.\n\nProcessed meat has been modified to either extend its shelf life or change the taste - and the main methods are smoking, curing, or adding salt or preservatives.\n\nPure mince does not count as processed, but bacon, sausages, hot dogs, salami, corned beef, pates and ham all do.", photo: "2001-1", comment: 0, imageCount: 0, postId: 3)
    }
}

struct PassageBody: View {
    @Binding var isScroll: Bool
    @State var reader: ScrollViewProxy?
    
    var title = ""
    var userName = ""
    var time = ""
    var photo = ""
    var passage = ""
    
    
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ScrollViewReader { reader in
                    VStack(alignment: .leading){
                        Spacer()
                            .frame(height: 40)
                        Text(title)
                            .font(.system(size: 22, weight: .semibold))
                            .id("title")
                            .tag("title")
                            .onAppear {
                                self.reader = reader
                            }
                        
                        Rectangle()
                            .frame(width: 56, height: 5)
                            .foregroundColor(Color("textBlack3"))
                        
                        HStack{
                            Image(photo)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 36, height: 36)
                                .cornerRadius(10)
                                .clipped()
                            
                            VStack(alignment: .leading){
                                Text(userName)
                                    .font(.subheadline)
                                Text(time)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.top, 4)
                        
                        Text(passage)
                            .padding(.top, 4)
                        
                        Spacer()
                            .frame(height: 40)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 30)
                .animation(.spring().delay(1).speed(0.8), value: isScroll)
                }
            }
//            .edgesIgnoringSafeArea(.all)
            .background(Color("lightGrey2"))
            .cornerRadius(isScroll ? 0 : 30)
            .simultaneousGesture(
                DragGesture().onChanged { value in
                    if value.translation.height > 0 {
                        isScroll.toggle()
                        print("to top")
                        reader?.scrollTo("title", anchor: .top)
                    }
                    else {
                        isScroll.toggle()
                        print("back")
                    }
                    
                }
            )
        }
        .edgesIgnoringSafeArea(.all)
        .animation(.spring(), value: isScroll)
        .offset(y: isScroll ? 0 : 270)
    }
    
}
