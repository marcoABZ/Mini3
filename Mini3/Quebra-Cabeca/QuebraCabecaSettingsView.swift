//
//  QuebraCabecaSettingsView.swift
//  Mini3
//
//  Created by Marco Zulian on 05/11/21.
//

import SwiftUI

struct QuebraCabecaSettingsView: View {
    @EnvironmentObject var student: Profile
    @State var settings: MemoryGameConfiguration
    
    init() {
        settings = MemoryGameConfiguration(verticalDivision: 1, horizontalDivision: 2, som: true, animacao: true, ordenacao: false, tipoOrdenacao: 0)
    }
    
    func loadSettings() {
        if let cfg = student.configs[.quebraCabeca] as? MemoryGameConfiguration {
            settings = cfg
        } else {
            student.configs[.quebraCabeca] = settings
        }
    }
    
    var body: some View {
        VStack (spacing: 30) {
            HStack {
                VStack (alignment: .leading) {
                    Text("Quantidade de divisoes")
                        .font(.title3)
                    Text("Quantidade de pedaços que a imagem será divididada.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
                
                Button
                { settings.horizontalDivision = max(2, settings.horizontalDivision - 1) }
                    label: { Image(systemName: "minus.circle") }
                    .foregroundColor(settings.horizontalDivision > 2 ? student.color : .gray)
                    .disabled(settings.horizontalDivision <= 2)
                        //TODO: Rever configurações de botão
                        .font(.system(size: 24, weight: .regular, design: .default))
                
            
                Text(String(describing: settings.horizontalDivision))
                    //TODO: Rever configurações do texto
                    .font(.system(size: 24, weight: .semibold, design: .default))
                
                Button
                { settings.horizontalDivision = min(10, settings.horizontalDivision + 1) }
                    label: { Image(systemName: "plus.circle") }
                    .foregroundColor(settings.horizontalDivision < 10 ? student.color : .gray)
                    .disabled(settings.horizontalDivision >= 10)
                        //TODO: Rever configurações de botão
                        .font(.system(size: 24, weight: .regular, design: .default))
                
                
            }
            
            Toggle(isOn: $settings.som) {
                VStack (alignment: .leading) {
                    Text("Sons")
                        .font(.title3)
                    Text("Ative ou desative os sons e interações sonoras dentro do jogo.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }.toggleStyle(SwitchToggleStyle(tint: student.color))
            
            Toggle(isOn: $settings.animacao) {
                VStack (alignment: .leading) {
                    Text("Animações")
                        .font(.title3)
                    Text("Ative ou desative as animações e interrações que podem ocorrer dentro do jogo.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }.toggleStyle(SwitchToggleStyle(tint: student.color))
            
            Toggle(isOn: $settings.ordenacao) {
                VStack (alignment: .leading) {
                    Text("Incluir ordenaçao")
                        .font(.title3)
                    Text("Ordene as pecas do quebra-cabeca com  letras ou números")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }.toggleStyle(SwitchToggleStyle(tint: student.color))

        }.onAppear(perform: loadSettings)
    }
}

struct QuebraCabecaSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        QuebraCabecaSettingsView()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(Profile(teste: true))
    }
}
