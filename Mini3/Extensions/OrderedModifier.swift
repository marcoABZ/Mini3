//
//  OrderedModifier.swift
//  Mini3
//
//  Created by Marco Zulian on 10/12/21.
//

import SwiftUI

struct Ordered: ViewModifier {
    
    let text: String
    let position: LabelPosition
    let fontSize: CGFloat
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: position == .left ? .leading : .bottom) {
                Text(text)
                    .foregroundColor(.white)
                    .font(.system(size: fontSize, weight: .bold, design: .default))
                    .padding(position == .left ? .horizontal : .vertical, 2)
                    .if(position == .left) { v in
                        v.frame(minWidth: 50, maxHeight: .infinity)
                    }
                    .if(position == .down) { v in
                        v.frame(maxWidth: .infinity)
                    }
                    .background(backgroundColor)
            }
    }
}

extension View {
    func ordered(text: String, position: LabelPosition, fontSize: CGFloat, backgoundColor: Color) -> some View {
        self.modifier(Ordered(text: text, position: position, fontSize: fontSize, backgroundColor: backgoundColor))
    }
}

enum LabelPosition {
    case down
    case left
}
