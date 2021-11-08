//
//  QuebraCabecaStartView.swift
//  Mini3
//
//  Created by Marco Zulian on 08/11/21.
//

import SwiftUI

struct QuebraCabecaStartView: View {
    @EnvironmentObject var student: Profile
    
    //TODO: Criar conceito de Perfil e usar o ativo como variável de ambiente. Acessar a cor por essa variável
    var color: Color = .orange
    
    var body: some View {
        color
            .ignoresSafeArea(.all)
            .overlay {
                VStack (spacing: headerToSettingsSpacing) {
                    GameHeaderView(gameName: "Quebra-cabeça")
                    HStack {
                        Spacer()
                        QuebraCabecaImageView(color: color)
                            .padding(.horizontal)
                        Spacer()
                        
                        //TODO: Estudar possibilidade/complexidade de trocar Divider por uma linha
                        Divider()
                            .background(color)
                        QuebraCabecaSettingsView(color: color)
                            .padding(.horizontal, settingsItemsSpacing)
                            .frame(maxWidth: settingsWidth)
                            .environmentObject(student)
                    }
                    .frame(height: settingsHeight)
                    .background()
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .circular))
                }.frame(width: settingsPlusImageWidth)
            }.onAppear {
                print(student)
            }
    }
    
    //MARK: Constantes
    //TODO: Checar constantes, tentar deixá-las independentes do device
    let headerToSettingsSpacing: CGFloat = 10
    let settingsItemsSpacing: CGFloat = 30
    let settingsWidth: CGFloat = 506
    let settingsHeight: CGFloat = 621
    let cornerRadius: CGFloat = 32
    let settingsPlusImageWidth: CGFloat = 1012
}

struct QuebraCabecaStartView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            let prof = Profile(teste: true)
            
            QuebraCabecaStartView()
                .previewInterfaceOrientation(.landscapeLeft)
                .environmentObject(prof)
        } else {
            let prof = Profile(teste: true)
            
            QuebraCabecaStartView()
                .environmentObject(prof)
        }
    }

}
