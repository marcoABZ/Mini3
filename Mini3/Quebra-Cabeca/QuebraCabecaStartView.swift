//
//  QuebraCabecaStartView.swift
//  Mini3
//
//  Created by Marco Zulian on 08/11/21.
//

import SwiftUI

struct QuebraCabecaStartView: View {
    @EnvironmentObject var student: Profile
    @State var puzzleManager: PuzzleManager
    
    var body: some View {
        NavigationView {

        student.color
            .ignoresSafeArea(.all)
            .overlay {
                VStack (spacing: headerToSettingsSpacing) {
                    GameHeaderView(gameName: "Quebra-cabeça")
                    HStack {
                        Spacer()
                        QuebraCabecaImageView(cfg: puzzleManager.settings)
                        Spacer()
                        
                        //TODO: Estudar possibilidade/complexidade de trocar Divider por uma linha
                        Divider()
                            .background(student.color)
                        
                        QuebraCabecaSettingsView(settings: puzzleManager.settings)
                            .padding(.horizontal, settingsItemsSpacing)
                            .frame(maxWidth: settingsWidth)
                    }
                    .frame(height: settingsHeight)
                    .background()
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .circular))
                }.frame(width: settingsPlusImageWidth)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
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
        let cfg = MemoryGameConfiguration()
        let manager = PuzzleManager(settings: cfg)
        
        QuebraCabecaStartView(puzzleManager: manager)
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(Profile(teste: true))
    }
}

//TODO: - QUEBRA-CABEÇA NO GERAL
//Colocar estrelas para indicar progresso
//Adicionar configuração para peça voltar ou não para a posição original
//Adicionar visualização de como o jogo deve ficar no final (figura fixa? botão para ver? opacidade?)
//Transição do jogo para a animação do fim
//Integração com a tela de anotações para os professores (precisa desenvolver mais)
//Abrir com configurações utilizadas anteriormente (precisa de integração maior com outras partes do app)
//Ajustar o código das configurações (só beneficia o código - prioridade média)
//Rever aparência da "ordenação" -> cobre muita informação do jeito que está
//Configurar ordenação com letras ao invés de números
//Pesquisa na internet por imagens
