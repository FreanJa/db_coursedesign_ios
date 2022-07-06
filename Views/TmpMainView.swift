//
//  TmpMainView.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/22.
//

import SwiftUI

struct TmpMainView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var backFirst = false
    @AppStorage("userName") var userName = "FreanJa"
    var body: some View {
        ZStack(alignment: .leading) {
            VStack{
                Spacer()
                HStack{
                    Spacer()
                }
            }
            VStack(alignment: .leading) {
                Image(systemName: "chevron.backward")
                    .font(.system(.title))
                    .padding(.bottom)
                    .fullScreenCover(isPresented: $backFirst, content: {
                        ContentView()
                    })
                    .onTapGesture {
                        backFirst.toggle()
                    }
//                    Text("Welcome back 👋 ,\n\(viewModel.account[0].userName)")
                Text("Welcome back 👋 ,\n\(userName)")
                    .font(.system(size: 32, weight: .bold, design: .serif))
                Spacer()
            }
            
        }
        .padding(30)
        
    }
}

struct TmpMainView_Previews: PreviewProvider {
    static var previews: some View {
        TmpMainView()
    }
}
