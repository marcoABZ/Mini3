//
//  QuebraCabecaSettingsView.swift
//  Mini3
//
//  Created by Marco Zulian on 05/11/21.
//

import SwiftUI

struct QuebraCabecaSettingsView: View {
    @State var qtdDivisoes: Int = 2
    @State var som: Bool = true
    @State var animacoes: Bool = true
    @State var ordenacao: Bool = false
    var color: Color
    
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
            label: {
                Image(systemName: "minus.circle")
            }.foregroundColor(color)
                
            
                Text(String(describing: qtdDivisoes))
                
                Button
                { qtdDivisoes = min(10, qtdDivisoes + 1) }
            label: { Image(systemName: "plus.circle") }.foregroundColor(color)
                
                
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

        }
    }
}

struct QuebraCabecaSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            QuebraCabecaSettingsView(qtdDivisoes: 1, som: true, animacoes: true, ordenacao: true, color: .red)
                .previewInterfaceOrientation(.landscapeLeft)
        } else {
            QuebraCabecaSettingsView(qtdDivisoes: 1, som: true, animacoes: true, ordenacao: true, color: .red)
        }
    }
}
