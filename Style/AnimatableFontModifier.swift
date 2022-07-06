//
//  AnimatableFontModifier.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/29.
//

import SwiftUI

struct AnimatableFontModifier: AnimatableModifier {
    var size: Double = 24
    var weight: Font.Weight = .regular
    var design: Font.Design = .default
    var foreColor: Color = Color("textBlack1")
    var text: String
    
    var animatableData: Double {
        get { size }
        set { size = newValue }
    }
    
    var animatableText: String {
        get { text }
        set { text = newValue }
    }
    
    func body(content: Content) -> some View {
        Text(text)
            .font(.system(size: size, weight: weight, design: design))
            .foregroundColor(foreColor)
    }
}

extension View {
    func animatableFont(text: String, size: Double = 24, weight: Font.Weight = .regular, design: Font.Design = .default, foreColor: Color = Color("textBlack1")) -> some View {
        self.modifier(AnimatableFontModifier(size: size, weight: weight, design: design, text: text))
            .foregroundColor(foreColor)
    }
}
