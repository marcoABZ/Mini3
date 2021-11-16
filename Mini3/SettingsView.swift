//
//  SettingsView.swift
//  Mini3
//
//  Created by Marco Zulian on 10/11/21.
//

//import SwiftUI
//
//struct SettingsView: View {
//    
//    let settings: [Configuration]
//    
//    func buildConfigurationSection(for items: [Configuration]) -> some View {
//        HStack {
//            VStack {
//                
//            }
//        }
//    }
//    
//    var body: some View {
//        ForEach(settings) { setting in
//            if let parent = settings as? ConfiguracaoPai {
//                
//            }
//        }
//    }
//}

import SwiftUI

struct PlusMinusPicker: View {
    @EnvironmentObject var student: Profile
    @ObservedObject var configuration: BaseConfiguration<Int>
    
    var body: some View {
        HStack (alignment: .center) {
            VStack (alignment: .leading) {
                Text(configuration.title)
                Text(configuration.description ?? "")
            }
            Spacer()
            Button
                { configuration.value = max(1, configuration.value - 1) }
                label: { Image(systemName: "minus.circle") }
                    .foregroundColor(configuration.value > 1 ? student.color : .gray)
                    .disabled(configuration.value <= 1)
                        //TODO: Rever configurações de botão
                        .font(.system(size: 24, weight: .regular, design: .default))
            
        
            Text(String(describing: configuration.value))
                //TODO: Rever configurações do texto
                .font(.system(size: 24, weight: .semibold, design: .default))
            
            Button
            { configuration.value = min(10, configuration.value + 1)}
            label: { Image(systemName: "plus.circle") }
                .foregroundColor(configuration.value < 10 ? student.color : .gray)
                .disabled(configuration.value >= 10)
                    //TODO: Rever configurações de botão
                    .font(.system(size: 24, weight: .regular, design: .default))
        }
    }
}
