//
//  ToggleSettingView.swift
//  Mini3
//
//  Created by Marco Zulian on 18/11/21.
//

import Foundation
import SwiftUI

struct ToggleSettingView: View {
    
    @EnvironmentObject var student: ProfileManager
    let iconName: String?
    let title: String
    let subtitle: String?
    @Binding var controlledVariable: Bool
    
    var body: some View {
        Toggle(isOn: $controlledVariable) {
            HStack {
                HStack (alignment: .top) {
                    if let iconName = iconName {
                        Image(systemName: iconName)
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .foregroundColor(student.getProfileColor())
                    }
                    VStack (alignment: .leading) {
                        Text(title)
                            .font(.system(size: 21, weight: .bold, design: .default))
                        if let subtitle = subtitle {
                            Text(subtitle)
                                .font(.system(size: 14, weight: .regular, design: .default))
                                .foregroundColor(.gray)
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                        }
                    }
                }
            }
        }.toggleStyle(SwitchToggleStyle(tint: student.getProfileColor()))
    }
}
