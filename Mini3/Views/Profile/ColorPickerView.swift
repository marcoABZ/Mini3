//
//  ColorPickerView.swift
//  Mini3
//
//  Created by Marco Zulian on 23/11/21.
//

import SwiftUI

struct ColorPickerView: View {
    
    @EnvironmentObject var profileManager: ProfileManager
    @Binding var editingProfile: ProfileModel
    var index: Int
    
    var body: some View {
        Button(action: {
            editingProfile.selectedColor = profileManager.availableColors[index]
        }) {
            Rectangle()
                .fill(Color(profileManager.availableColors[index]))
                .frame(width: 64, height: 64)
                .cornerRadius(16)
        }
    }
}
