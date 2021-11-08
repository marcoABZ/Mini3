//
//  QuebraCabecaSettingsView.swift
//  Mini3
//
//  Created by Marco Zulian on 05/11/21.
//

import SwiftUI

struct QuebraCabecaSettingsView: View {
    @EnvironmentObject var student: Profile
    @State var qtdDivisoes: Int = 2
    @State var som: Bool = true
    @State var animacoes: Bool = true
    @State var ordenacao: Bool = false
    var color: Color = .orange
    
    func loadConfigs() {
        if let cfg = student.configs[.quebraCabeca] as? MemoryGameConfiguration {
            qtdDivisoes = cfg.verticalDivision
            som = cfg.som
            animacoes = cfg.animacao
            ordenacao = cfg.ordenacao
        }
    }
    
    var body: some View {
        VStack (spacing: 30) {
            HStack {
                VStack (alignment: .leading) {
                    Text("Quantidade de divisoes")
                        .font(.title3)
                    Text("Selecione quantas divisoes teram na sua imagem.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
                
                Button
                    { qtdDivisoes = max(2, qtdDivisoes - 1) }
                    label: { Image(systemName: "minus.circle") }
                        .foregroundColor(qtdDivisoes > 2 ? color : .gray)
                        .disabled(qtdDivisoes <= 2)
                        //TODO: Rever configurações de botão
                        .font(.system(size: 24, weight: .regular, design: .default))
                
            
                Text(String(describing: qtdDivisoes))
                    //TODO: Rever configurações do texto
                    .font(.system(size: 24, weight: .semibold, design: .default))
                
                Button
                    { qtdDivisoes = min(10, qtdDivisoes + 1) }
                    label: { Image(systemName: "plus.circle") }
                        .foregroundColor(qtdDivisoes < 10 ? color : .gray)
                        .disabled(qtdDivisoes >= 10)
                        //TODO: Rever configurações de botão
                        .font(.system(size: 24, weight: .regular, design: .default))
                
                
            }
            
            Toggle(isOn: $som) {
                VStack (alignment: .leading) {
                    Text("Sons")
                        .font(.title3)
                    Text("Ative ou desative os sons e interações sonoras dentro do jogo.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }.toggleStyle(SwitchToggleStyle(tint: color))
            
            Toggle(isOn: $animacoes) {
                VStack (alignment: .leading) {
                    Text("Animações")
                        .font(.title3)
                    Text("Ative ou desative as animações e interrações que podem ocorrer dentro do jogo.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }.toggleStyle(SwitchToggleStyle(tint: color))
            
            Toggle(isOn: $ordenacao) {
                VStack (alignment: .leading) {
                    Text("Incluir ordenaçao")
                        .font(.title3)
                    Text("Ordene as pecas do quebra-cabeca com  letras ou números")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }.toggleStyle(SwitchToggleStyle(tint: color))

        }.onAppear(perform: loadConfigs)
    }
}

struct QuebraCabecaSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            QuebraCabecaSettingsView()
                .previewInterfaceOrientation(.landscapeLeft)
                .environmentObject(Profile(teste: true))
        } else {
            QuebraCabecaSettingsView()
                .environmentObject(Profile(teste: true))
        }
    }
}
