//
//  GameCard.swift
//  Mini3
//
//  Created by Marco Zulian on 03/12/21.
//

import SwiftUI

struct GameCard: View {
    
    let game: Game
    let mascote: Mascotes
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            game.getCoverImage(mascote: mascote)
                    .resizable()
                    .cornerRadius(16)
                    .aspectRatio(contentMode: .fit)
                    .padding(.vertical, 10)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
                    .blocked(!game.isAvailable())
            
            Text(game.rawValue)
                .font(.system(size: 17, weight: .bold, design: .rounded))
            Text(game.getDescription())
                .font(.system(size: 14, weight: .regular, design: .rounded))
        }
    }
    
}


struct Blocked: ViewModifier {
    var condition: Bool
    func body(content: Content) -> some View {
        if condition {
            content
                .overlay {
                    Color.black
                        .cornerRadius(16)
                        .opacity(0.5)
                        .padding(.vertical, 10)
                    Image(systemName: "lock.slash.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 64))
                }
        }
        else {
            content
        }
    }
}

extension View {
    func blocked(_ condition: Bool) -> some View {
        modifier(Blocked(condition: condition))
    }
}
