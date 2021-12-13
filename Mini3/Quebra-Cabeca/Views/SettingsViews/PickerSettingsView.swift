//
//  PickerSettingsView.swift
//  Mini3
//
//  Created by Marco Zulian on 10/12/21.
//

import SwiftUI

struct PickerSettingsView<T>: View where T: Identifiable & CaseIterable & RawRepresentable & Equatable {
    
    @EnvironmentObject var selectedProfileManager: SelectedProfileManager
    let iconName: String?
    let title: String
    let subtitle: String?
    var values: [T]
    @Binding var controlledVariable: T
    
    var body: some View {
        HStack (alignment: .top){
            if let iconName = iconName {
                Image(systemName: iconName)
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .foregroundColor(selectedProfileManager.getProfileColor())
            }
            HStack (alignment: .center) {
                VStack (alignment: .leading, spacing: 5) {
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
                Spacer()
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(values) { val in
                        Button { controlledVariable = val }
                        label: {
                            Text(String(describing: val.rawValue))
                                    .font(.system(size: 32, weight: .bold, design: .default))
                                    .foregroundColor(controlledVariable == val ? .white : .black)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .addBorder(Color(uiColor: .systemGray3), width: controlledVariable == val ? 0 : 2, cornerRadius: 8)
                                            .foregroundColor(controlledVariable == val ? selectedProfileManager.getProfileColor() : Color(uiColor: .systemGray5))
                                    )
                        }
                    }
                }
            }
        }
    }
}
