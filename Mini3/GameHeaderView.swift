//
//  GameHeaderView.swift
//  Mini3
//
//  Created by Marco Zulian on 05/11/21.
//

import SwiftUI

struct GameHeaderView: View {
    let gameName: String
    
    var body: some View {
        HStack {
            NavigationLink(destination: DashboardView()) {
                HStack {
                    Image(systemName: "arrow.left.circle")
                        .font(.system(size: 46, weight: .regular, design: .default))
                }
            }
            .padding()
            
            Spacer()
            
            //TODO: Encontrar uma forma de alinhar o texto no centro, mesmo com o botão de voltar na View
            Text(gameName)
                .font(.system(size: 24, weight: .bold, design: .default))
                .alignmentGuide(HorizontalAlignment.leading, computeValue: { d in
                    d.width / 2.0
                })
            
            Spacer()
        }.foregroundColor(.white)
    }
}

struct GameHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            GameHeaderView(gameName: "Quebra-cabeça")
                .previewInterfaceOrientation(.landscapeLeft)
        } else {
            // Fallback on earlier versions
        }
    }
}
