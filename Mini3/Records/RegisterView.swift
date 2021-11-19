//
//  RegisterView.swift
//  Mini3
//
//  Created by Pablo Penas on 18/11/21.
//

import SwiftUI

//struct AddTeacherView

struct RegisterView: View {
    @EnvironmentObject var profileManager: ProfileManager
    var body: some View {
        ZStack {
            profileManager.availableColors[0]
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.opacity(0.3), lineWidth: 5)
                )
                .ignoresSafeArea()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .padding()
            .environmentObject(ProfileManager())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
