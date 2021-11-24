//
//  BackgroundColorPickerView.swift
//  Mini3
//
//  Created by Marco Zulian on 23/11/21.
//

import SwiftUI

struct BackgroundColorPickerView: View {
    
    @EnvironmentObject var profileManager: ProfileManager
    
    var body: some View {
        HStack(spacing: 24) {
            Button(action: {
                profileManager.editingProfile.selectedColor = profileManager.neutralColor
            }) {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 64, height: 64)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 3)
                            .overlay(
                                Path { path in
                                    path.move(to: CGPoint(x: 48, y: 16))
                                    path.addLine(to: CGPoint(x: 16, y: 48))
                                }
                                    .stroke(Color.gray, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                            )
                    )
            }
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 24) {
                ForEach(0..<profileManager.availableColors.count) { i in
                    ColorPickerView(index: i)
                }
            }

//            VStack(spacing: 24) {
//                HStack(spacing: 24) {
//                    ForEach(0..<profileManager.availableColors.count/2) { i in
//                        ColorPickerView(index: i)
//                    }
//                }
//                HStack(spacing: 24) {
//                    ForEach(profileManager.availableColors.count/2..<profileManager.availableColors.count) { i in
//                        ColorPickerView(index: i)
//                    }
//                }
//            }
        }.padding(.bottom, 56)
    }
}
