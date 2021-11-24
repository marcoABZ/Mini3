//
//  ColorPickerView.swift
//  Mini3
//
//  Created by Marco Zulian on 23/11/21.
//

import SwiftUI

struct ColorPickerView: View {
    
    @EnvironmentObject var profileManager: ProfileManager
    var index: Int
    
    var body: some View {
        Button(action: {
            profileManager.editingProfile.selectedColor = profileManager.availableColors[index]
        }) {
            Rectangle()
                .fill(profileManager.availableColors[index])
                .frame(width: 64, height: 64)
                .cornerRadius(16)
        }
    }
}
