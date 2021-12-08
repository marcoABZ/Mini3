//
//  SatisfactionIndicator.swift
//  Mini3
//
//  Created by Marco Zulian on 08/12/21.
//

import SwiftUI

struct SatisfactionIndicator: View {
    
    let satisfaction: Satisfaction
    let percentage: Float
    let color: Color
    
    var body: some View {
        HStack {
            Image("\(satisfaction)Colored")
                .resizable()
                .frame(width: 24, height: 24)
                .background(Color("satisfactionGray"))
                .cornerRadius(12)
            Text("\(percentage, specifier: "%.f")%")
        }
        .frame(width: 80, height: 36)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(color, lineWidth: 2)
        )
    }
}
