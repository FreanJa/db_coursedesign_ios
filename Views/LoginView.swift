//
//  LoginView.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/22.
//

import SwiftUI

struct LoginView: View {
    @State var account: String = ""
    @State var passwd: String = ""
    @State var username: String = ""
    @State var confirm: String = ""
    @State var state: String = ""
    
    @State var hasAccount = true
    @State var error = true
    @AppStorage("isLogin") var isLogin = false
    @AppStorage("userName") var userName = ""
    @AppStorage("userId") var userId = 0
    @AppStorage("photo") var userPhoto = ""
    @AppStorage("password") var userPasswd = ""
    @AppStorage("email") var userEmail = ""
    
    @State var sendReq = false
    @State var toMain = false
    
    @EnvironmentObject var viewModel: ViewModel
    
    var signIn = [
        "state": 0,
        "account": "",
        "passwd": ""
    ] as [String : Any]
    
    var signUp = [
        "state": 1,
        "email": "",
        "username": "",
        "passwd": ""
    ] as [String : Any]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading){
                VStack(spacing: 20) {
                    Spacer()
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width:130, height: 130)
                        .offset(y: 60)
                    
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 18) {
                            ZStack(alignment: .leading) {
                                Text("Account")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color("lightGrey"))
                                    .opacity(hasAccount ? 1 : 0)
                                    .offset(x: hasAccount ? 0 : -60)
                                Text("Email")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color("lightGrey"))
                                    .opacity(hasAccount ? 0 : 1)
                                    .offset(x: hasAccount ? 40 : 0)
                            }
                            
                            TextField("", text: $account)
                                .padding()
                                .frame(width: 327, height: 49)
                                .background(Color("lightGrey"))
                                .cornerRadius(20)
                                .padding(.bottom)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                
                        }
                        
                        VStack(alignment: .leading, spacing: 18) {
                            Text("Username")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("lightGrey"))
                            
                            TextField("", text: $username)
                                .padding()
                                .frame(width: 327, height: 49)
                                .background(Color("lightGrey"))
                                .cornerRadius(20)
                                .padding(.bottom)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                        .opacity(hasAccount ? 0 : 1)
                        .offset(y: hasAccount ? 110 : 0)
                        
                        
                        VStack(alignment: .leading, spacing: 18) {
                            Text("Password")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("lightGrey"))
                            SecureField("", text: $passwd)
                                .padding()
                                .frame(width: 327, height: 49)
                                .background(Color("lightGrey"))
                                .cornerRadius(20)
                                .padding(.bottom)
                        }
                        .offset(y: hasAccount ? -110 : 0)
                        
                        VStack(alignment: .leading, spacing: 18) {
                            Text("Confirm Password")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("lightGrey"))
                            
                            SecureField("", text: $confirm)
                                .padding()
                                .frame(width: 327, height: 49)
                                .background(Color("lightGrey"))
                                .cornerRadius(20)
                        }
                        .opacity(hasAccount ? 0 : 1)
                        .offset(y: hasAccount ? 110 : 0)
                        
                        
                    }
                    .offset(y: 80)
                      
                    HStack{
                        Spacer()
                        Text("Forgot Password?")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color("lightCyan"))
                    }
                    .opacity(hasAccount ? 1 : 0)
                    .offset(y: hasAccount ? -110 : 0)
                    
                    
                    Button(action: {
                            if (hasAccount) {
                                if account.isEmpty {
                                    state = "The account cannot be empty"
                                }
                                else if passwd.isEmpty {
                                    state = "The password cannot be empty"
                                }
                                else {
                                    state = ""
                                    let msg = [
                                        "state": 0,
                                        "account": account,
                                        "passwd": passwd
                                    ] as [String : Any]
                                    
                                    viewModel.accountOpr(parameters: msg) { isSuccess in
                                        DispatchQueue.main.async {
                                            if isSuccess {
                                                if viewModel.info[0].error {
                                                    state = viewModel.info[0].desc
                                                }
                                                else {
                                                    userName = viewModel.account[0].userName
                                                    userPhoto = viewModel.account[0].photo
                                                    userPasswd = viewModel.account[0].password
                                                    userEmail = viewModel.account[0].email
                                                    userId = viewModel.account[0].userId
                                                    
                                                    print("Login page userName: \(viewModel.account[0].userName)")
                                                    print("Login page userName: \(userName)")
                                                    toMain.toggle()
                                                    isLogin = true
                                                }
                                            }
                                            else {
                                                print("not success")
                                            }
                                        }
                                    }
                                }
                            }
                            else {
                                if account.isEmpty {
                                    state = "The E-mail cannot be empty"
                                }
                                else if !account.isValidEmail {
                                    state = "Invalied email address"
                                }
                                else if username.isEmpty {
                                    state = "The Username cannot be empty"
                                }
                                else if passwd.isEmpty {
                                    state = "The password cannot be empty"
                                }
                                else if confirm.isEmpty {
                                    state = "You need to enter your password again"
                                }
                                else if confirm != passwd {
                                    state = "The passwords entered are different"
                                }
                                else {
                                    state = ""
                                    let msg = [
                                        "state": 1,
                                        "email": account,
                                        "username": username,
                                        "passwd": passwd
                                    ] as [String : Any]
                                    viewModel.accountOpr(parameters: msg) { isSuccess in
                                        DispatchQueue.main.async {
                                            if isSuccess {
                                                if viewModel.info[0].error {
                                                    state = viewModel.info[0].desc
                                                }
                                                else {
                                                    hasAccount.toggle()
                                                }
                                            }
                                            else {
                                                print("not success")
                                            }
                                        }
                                    }
                                }
                            }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 110, height: 40)
                                .foregroundColor(Color("lightCyan"))
                            Text(hasAccount ? "Sign in" : "Sign up")
                                .foregroundColor(.white)
                                .font(.system(size: 13, weight: .medium))
                        }
                        
                    })
                    .padding(.top, 60)
                    .offset(y: hasAccount ? -90 : 30)
                    .fullScreenCover(isPresented: $toMain, content: {
//                        HomeView()
                        IndexView()
                    })
                    Spacer()
                    
                    ZStack {
                        HStack{
                            Text("Don’t have an account?")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color("lightGrey"))
                            Text("Sign up")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color("lightCyan"))
                            
                        }
                        .opacity(hasAccount ? 1 : 0)
                        .offset(y: hasAccount ? 0 : -20)
                        
                        HStack{
                            Text("Already have an account?")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color("lightGrey"))
                            Text("Sign in")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color("lightCyan"))
                        }
                        .opacity(hasAccount ? 0 : 1)
                        .offset(y: hasAccount ? 20 : 0)
                        
                    }
                    .onTapGesture {
                        state = ""
                        hasAccount.toggle()
                    }
                }
                .animation(.spring(), value: hasAccount)
                .padding()
                .padding(.horizontal, 50)
                .offset(y: -10)
                
                Text(state)
                    .font(.system(size: 14, weight: .medium))
                    .offset(y: hasAccount ? 60 : 280)
                    .foregroundColor(Color("lightCyan"))
                    .padding(.horizontal, 76)
                    .animation(.spring(), value: hasAccount)
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color("LaunchScreenBackground"))
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
        }
    }
}

extension String {
    
    var isValidEmail: Bool {
        let name = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let domain = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let emailRegEx = name + "@" + domain + "[A-Za-z]{2,8}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }
    
}
