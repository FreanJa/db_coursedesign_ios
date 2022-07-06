//
//  ContentView.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/18.
//

import SwiftUI


struct ContentView: View {
//    @Environment(\.presentationMode) var presentationModel
    @EnvironmentObject var viewModel: ViewModel
    @AppStorage("isLogin") var isLogin = false
    @AppStorage("selectedTab") var selectedTab: Tab = .index
    
    @State var toLogin = false
    @State var toHome = false
    let json = [
        "user": "admin",
        "passwd": "admin123"
    ]
    
//    let item: PostModel
    @State var json_data = "hello flask!"
    
    
    var body: some View {
        ZStack {
            Image("launch")
            VStack {
                Spacer()
                Button(action: {
                    if (isLogin){
                        toHome = true
                    }
                    else {
                        toLogin = true
                    }
                    selectedTab = .index
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 240, height: 50)
                            .foregroundColor(Color("lightCyan"))
                            
                        
                        Text("GET STARTED")
                            .foregroundColor(Color("textBlack3"))
                            .font(.system(size: 18, weight: .black, design: .serif))
                            .tracking(1)
                            
                    }
                    .shadow(radius: 10, y: 20)
                    .padding(.bottom, 100)
                    
                })
                .fullScreenCover(isPresented: $toLogin, content: {
                    LoginView()
                })
                .fullScreenCover(isPresented: $toHome, content: {
                    IndexView()
                })
                
            }
            .onAppear{
                if (isLogin) {
                    toHome = true
                }
                print("contentView isLogin: \(isLogin)")
            }
        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("LaunchScreenBackground"))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
