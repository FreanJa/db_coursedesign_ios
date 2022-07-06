//
//  AccountView.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/28.
//

import SwiftUI

struct AccountView: View {
    @AppStorage("isLogin") var isLogin = false
    @AppStorage("userName") var userName = "FreanJa Liu"
    @AppStorage("userId") var userId = 0
    @AppStorage("email") var userEmail = "root@freanja.cn"
    @AppStorage("password") var userPasswd = ""
    @AppStorage("photo") var userPhoto = "58"
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: ViewModel
    
    @State var toGuide = false
    @State var name = ""
    @State var email = ""
    
    @State var password = ""
    @State var password2 = ""
    @State var tip = ""
    
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    profile
                }
                
                Section {
                    NavigationLink {
                        SettingView
                    } label: {
                        Label("Settings", systemImage: "gear")
                    }
                    
                    NavigationLink {
                        HelpView
                    } label: {
                        Label("Help", systemImage: "questionmark.circle")
                        
                    }
                    
                    
                }
                .listRowSeparator(.automatic)
                
                
                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
                    isLogin = false
                    toGuide = true
                    print("accountView isLogin: \(isLogin)")
                }, label: {
                    Text("Sign out")
                        .frame(maxWidth: .infinity)
                })
                .tint(.red)
                .fullScreenCover(isPresented: $toGuide, content: {
                    LoginView()
                })
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
        }
    }
    
    var modifyName: some View {
        List {
            ZStack{
                TextEditor(text: $name)
            }
            .navigationTitle("USER NAME")
            .toolbar{
                Button(action: {
                    userName = name
                    viewModel.modifyAccount(parameters: ["tag": 0, "userId": userId,  "new": name]) { isSuccess in
                        DispatchQueue.main.async {
                            if isSuccess {
                                if !viewModel.info[0].error {
                                    print("modify success")
                                }
                            }
                        }
                        
                    }
                }, label: {
                    Text("Save")
                })
            }
        }
    }
    
    var modifyEmail: some View {
        List {
            ZStack{
                TextEditor(text: $email)
            }
            .navigationTitle("USER NAME")
            .toolbar{
                Button(action: {
                    userEmail = email
                    viewModel.modifyAccount(parameters: ["tag": 3, "userId": userId,  "new": email]) { isSuccess in
                        DispatchQueue.main.async {
                            if isSuccess {
                                if !viewModel.info[0].error {
                                    print("modify success")
                                }
                            }
                        }
                        
                    }
                }, label: {
                    Text("Save")
                })
            }
        }
    }
    
    var modifyPassword: some View {
        List {
            Section(header: Text("old password")){
                TextEditor(text: $password)
            }
            
            Section(header: Text("new password")){
                TextEditor(text: $password2)
            }
            
            Section(header: Text(tip)){
                
            }
        }
        .navigationTitle("USER NAME")
        .toolbar{
            Button(action: {
                if ( password != userPasswd) {
                    tip = "The old password is incorrect!"
                    print("password: " + password)
                    print("password2: " + password2)
                    print("userPasswd: " + userPasswd)
                }
                else {
                    tip = ""
                    userPasswd = password2
                    viewModel.modifyAccount(parameters: ["tag": 2, "userId": userId,  "new": password2]) { isSuccess in
                        DispatchQueue.main.async {
                            if isSuccess {
                                if !viewModel.info[0].error {
                                    print("modify success")
                                    
                                }
                            }
                        }
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Save")
            })
        }
    }
    
    var SettingView: some View {
        VStack {
            Image("peep-" + userPhoto)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .padding()
                .background(.white)
                .cornerRadius(50)
                .clipped()
                .padding(.top)
            
            List {
                Section {
                    NavigationLink {
                        modifyName
                    } label: {
                        HStack {
                            Text("user name")
                            Spacer()
                            Text(userName)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    NavigationLink {
                        modifyEmail
                    } label: {
                        HStack {
                            Text("e-mail")
                            Spacer()
                            Text(userEmail)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    NavigationLink {
                        modifyPassword
                    } label: {
                        Text("password")
                    }
                    
                }
                
            }
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
        }
        .background(Color("lightGrey5"))
    }
    
    var HelpView: some View {
        VStack(alignment: .leading) {
            Text("Contact me:")
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .padding(.bottom)
            
            Text("root@freanja.cn\nblog.freanja.cn\ngithub.com/freanja")
                .font(.system(size: 26, weight: .black, design: .monospaced))
                .lineSpacing(10)
        }
        .navigationTitle("Help")
        .navigationBarTitleDisplayMode(.inline)

    }
    
    var profile: some View {
        VStack {
            Image("peep-" + userPhoto)
                .resizable()
                .scaledToFill()
                .frame(width: 32)
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(AnimatedBlobView().frame(width: 400, height: 414).offset(x: 200, y: 0).scaleEffect(0.5))
                .background(HexagonView().offset(x: -50, y: -100))
            Text(userName)
                .font(.title.weight(.semibold))
            
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
