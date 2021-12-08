//
//  CardifyModifier.swift
//  Mini3
//
//  Created by Marco Zulian on 08/12/21.
//

import SwiftUI

struct Cardify: Animatable, ViewModifier {
    
    init(isFaceUp: Bool, background: AnyView) {
        rotation = isFaceUp ? 180 : 0
        self.background = background
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double = 0
    var background: AnyView
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 16)
            
            if rotation > 90 {
                shape
                    .overlay { background.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0)) }
            } else {
                shape
                    .fill(Color.white)
                    .overlay { content }
            }
        }
        .zIndex(2)
        .frame(width: 300, height: 428)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
}

extension View {
    func cardify(isFaceUp: Bool, background: AnyView) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, background: background))
    }
}
