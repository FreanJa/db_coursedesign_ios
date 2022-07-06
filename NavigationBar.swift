//
//  NavigationBar.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/29.
//

import SwiftUI

struct NavigationBar: View {
    @AppStorage("userName") var userName = ""
    @AppStorage("photo") var userPhoto = "58"
    
    @Binding var hasScrolled: Bool
    @State var showSheet = false
    @State var showAccount = false
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
            
            VStack(alignment: .leading){
                Text("Hello \(userName)".capitalized)
                    .foregroundColor(Color("textGray1"))
                    .font(.system(size: 16))
                    .padding(.top, 20)
                    .opacity(hasScrolled ? 0 : 1)
                
                Text("")
                    .animatableFont(text: "Welcome back! 👋", size: hasScrolled ? 22 : 24, weight: .bold, design: .serif, foreColor: hasScrolled ? Color("textBlack1") : .black)
                    .offset(y: hasScrolled ? -14 : 0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            
            HStack(spacing: 16) {
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.body.weight(.bold))
                        .frame(width: 36, height: 36)
                        .foregroundColor(.secondary)
                        .background(.ultraThinMaterial, in:
                                        RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .sheet(isPresented: $showSheet) {
                    SearchView()
                }
                    
                Button {
                    showAccount.toggle()
                } label: {
                    ZStack{
                        Image("peep-" + userPhoto)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 24, height: 24)
                            .padding(2)
                            .background(.white)
                            .cornerRadius(100)
                            
                    }
                    .frame(width: 36, height: 36)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .sheet(isPresented: $showAccount) {
                    AccountView()
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 20)
            .padding(.top, 20)
            .offset(y: hasScrolled ? -4 : 0)
            
        }
        .frame(height: hasScrolled ? 44 : 70)
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear{
            print("navigation bar userName: \(userName)")
        }
        
        
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(hasScrolled: .constant(false))
    }
}
