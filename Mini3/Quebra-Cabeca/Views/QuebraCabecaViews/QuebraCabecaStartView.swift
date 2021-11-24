//
//  QuebraCabecaStartView.swift
//  Mini3
//
//  Created by Marco Zulian on 08/11/21.
//

import SwiftUI

struct QuebraCabecaStartView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var student: ProfileManager
    @EnvironmentObject var dashboardManager: DashboardManager
    @State var puzzleManager: PuzzleManager
    
    var body: some View {
//        NavigationView {

        student.getProfileColor()
            .ignoresSafeArea(.all)
            .overlay {
                    HStack {
                        Spacer()
                        QuebraCabecaImagePickerView(cfg: puzzleManager.settings)
                        Spacer()
                        
                        //TODO: Estudar possibilidade/complexidade de trocar Divider por uma linha
                        Divider()
                            .background(student.getProfileColor())
                        
                        QuebraCabecaSettingsView(settings: puzzleManager.settings)
                            .padding(.horizontal, settingsItemsSpacing)
                            .frame(maxWidth: settingsWidth)
                    }
                    .frame(width: settingsPlusImageWidth, height: settingsHeight)
                    .background()
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .circular))
                }
//            .frame(width: settingsPlusImageWidth)
//            }
            .navigationBarHidden(false)
            .navigationTitle("Quebra-cabeça")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
               .toolbar(content: {
                  ToolbarItem (placement: .navigation)  {
                     Image(systemName: "arrow.backward.circle")
                     .foregroundColor(.white)
                     .onTapGesture {
                         dashboardManager.hasSidebar = true
                         self.presentation.wrappedValue.dismiss()
                     }
                  }
               })
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//        .navigationTitle("Quebra-cabeça")
//        .navigationBarTitleDisplayMode(.inline)
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

//TODO: - QUEBRA-CABEÇA NO GERAL
//Transição do jogo para a animação do fim
//Integração com a tela de anotações para os professores (precisa desenvolver mais)
//Abrir com configurações utilizadas anteriormente (precisa de integração maior com outras partes do app)
//Pesquisa na internet por imagens
