//
//  BlockedModifier.swift
//  Mini3
//
//  Created by Marco Zulian on 08/12/21.
//

import SwiftUI

struct Blocked: ViewModifier {
    
    let condition: Bool
    
    func body(content: Content) -> some View {
        if condition {
            content
                .overlay {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.black)
                            .opacity(0.5)
                        Image(systemName: "lock.slash.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 56))
                    }
                }
        } else {
            content
        }
    }
}

extension View {
    func blocked(_ condition: Bool) -> some View {
        self.modifier(Blocked(condition: condition))
    }
}
