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
                    .fill(Color.clear)
                    .overlay { background.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0)) }
            } else {
                shape
                    .fill(Color.white)
                    .overlay { content }
            }
        }
        .zIndex(2)
        //TODO: Ajustar frame fixo
//        .frame(minWidth: 300, minHeight: 428)
        .aspectRatio(0.7, contentMode: ContentMode.fill)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
        .scaleEffect(1.4 - pow(0.4, abs((rotation - 90) / 90)))
    }
}

extension View {
    func cardify(isFaceUp: Bool, background: AnyView) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, background: background))
    }
}
