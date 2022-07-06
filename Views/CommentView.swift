//
//  CommentView.swift
//  testMysql
//
//  Created by FreanJa L on 2022/6/11.
//

import SwiftUI

struct CommentView: View {
    @AppStorage("photo") var userPhoto = "9"
    @AppStorage("userName") var user = ""
    @AppStorage("userId") var userId = 0
    
    var commentsNum = 2
    var title = "Is Red Meat Back On The Menu?"
    var userName = "Frank Gomez"
    var time = "April 9, 2020, 13:30 PM"
    var postId = 0
    
    @State var newComment: String = ""
    @FocusState private var inputIsFocused: Bool
    
    @EnvironmentObject var viewModel: ViewModel

    
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: 4) {
                    Text("Leave a Comment")
                        .font(.system(size: 18, weight: .bold))
                        .tracking(0.2)
                        .foregroundColor(.black)
                    
                    Text("(" + String(viewModel.commentCount) + " Comments)")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color("textGray1"))
                        .tracking(0.6)
                }
                .padding(.vertical, 10)
                .padding(.leading, 28)
                .padding(.top, 20)
                .onTapGesture {
                    inputIsFocused = false
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(title)
                            .font(.system(size: 20, weight: .bold))
                            
                        HStack(spacing: 30){
                                Text(userName)
                                    .font(.caption)
                            
                                Text(time)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                    }
                    .padding(.vertical, 28)
                    .padding(.leading, 28)
                    
                    Spacer()
                }
                .background(Color("lightGrey3"))
                .onTapGesture {
                    inputIsFocused = false
                }
                
                CommentSection()
                    .onTapGesture {
                        inputIsFocused = false
                    }
                
                Spacer()
            }
            
            Color(.black).opacity(inputIsFocused ? 0.2 : 0)
                .onTapGesture {
                    inputIsFocused = false
                }
            
            VStack {
                Spacer()
                HStack{
                    Image("peep-" + userPhoto)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 36, height: 36)
                        .padding(4)
                        .background(.white)
                        .cornerRadius(40)
                    
                    TextField("Write a Comment...", text: $newComment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .lineLimit(4)
                        .padding()
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                        .focused($inputIsFocused)
                    
                    Button(action: {
                        inputIsFocused = false
                        
                        let msg = [
                            "postId": postId,
                            "userId": userId,
                            "comment": newComment
                        ] as [String: Any]
                        
                        viewModel.createComment(parameters: msg) { isSuccess in
                            DispatchQueue.main.async {
                                if isSuccess {
                                    if !viewModel.info[0].error {
                                        print("add success")
                                    }
                                }
                            }
                            
                        }
                        
                        newComment = ""
                        
                    }, label: {
                        Image(systemName: "arrow.up.circle")
                            .font(.system(size: 30, weight: .light))
                            .foregroundColor(Color("darkGrey"))
                    })
                }
                .padding(.horizontal)
                .padding(.bottom, 44)
                .background(Color("lightGrey4"))
                .offset(y: inputIsFocused ? -320 : 30)
                .animation(.spring().speed(1.8), value: inputIsFocused)

            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}

struct CommentSection: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(viewModel.comments, id: \.commentsId) { comment in
                    VStack(alignment: .leading) {
                        HStack{
                            Image("peep-" + comment.userPhoto)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 36, height: 36)
                                .cornerRadius(40)
                                .clipped()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(comment.userName)
                                    .font(.footnote)

                                Text(comment.time)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }

                            Spacer()
                        }
                        
                        Text(comment.text)
                            .font(.caption)
                            .padding(.top, 1)
                    }
                    .padding()
                    
                    Color("lightGrey4")
                        .frame(height: 1)
                }
            }
            
            Spacer()
                .frame(height: 70)
        }
        
    }
}
