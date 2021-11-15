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
