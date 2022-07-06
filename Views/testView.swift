//
//  testView.swift
//  testMysql
//
//  Created by FreanJa L on 2022/6/12.
//

import SwiftUI

struct testView: View {
    @State var text = ""
    var body: some View {
//        List{
//            Text("Enter the message")
            
            ZStack{
                TextEditor(text: $text)
                Text(text).opacity(0).padding(8)
            }
//        }
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
