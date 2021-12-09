//
//  GameCard.swift
//  Mini3
//
//  Created by Marco Zulian on 03/12/21.
//

import SwiftUI

struct GameCard: View {
    
    let game: Game
    let mascote: Mascotes
    let profile: ProfileModel
    
    @State var isFaceUp: Bool = true
    
    @EnvironmentObject var recordManager: RecordManager
    @EnvironmentObject var selectedProfileManager: SelectedProfileManager
    @Binding var isActive: Bool
    @Binding var hasSidebar: Bool
    
    @State var fractions: [Float]
    let width = 254
    
    
    var body: some View {
        VStack (alignment: .leading) {
            NavigationLink(
                destination:
                    QuebraCabecaStartView(
                        puzzleManager: PuzzleManager(settings: PuzzleConfiguration()),
                        rootIsActive: $isActive)
                    .environmentObject(selectedProfileManager),
                isActive: $isActive
            ) {
                VStack {
                    backFace
                }
                .cardify(isFaceUp: isFaceUp, background: AnyView(frontFace))
            }
            .isDetailLink(false)
            .disabled(!game.isAvailable())
            .if(game.isAvailable()) { view in
                view.simultaneousGesture(
                    TapGesture().onEnded {
                        hasSidebar = false
                        recordManager.currentGame = .quebraCabeca
                    }
                )
            }
            .padding(.vertical,32)
            .padding(.leading)
            
            Text(game.rawValue)
                .font(.system(size: 17, weight: .bold, design: .rounded))
            Text(game.getDescription())
                .font(.system(size: 14, weight: .regular, design: .rounded))
            
            Button(action: {
                withAnimation() {
                    isFaceUp.toggle()
                }
            }) { Text("Trocar") }
        }
    }
    
    var frontFace: some View {
        Image(game.getCoverImage(mascote: mascote))
                .resizable()
                .cornerRadius(16)
                .aspectRatio(contentMode: .fit)
                .blocked(!game.isAvailable())
    }
    
    var backFace: some View {
        VStack {
            Image(Mascotes.getCardCoverImages(animal: mascote, jogo: game))
                .resizable()
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Jogo \(game.rawValue)")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                    Text(recordManager.getLastRecordDate(game: game, student: profile) ?? "Nenhum registro")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                }
                Spacer()
            }
            .padding(.horizontal, 22)
            
            Spacer()
            
            VStack {
                HStack(spacing: 0) {
                    ForEach(Satisfaction.allCases, id: \.self) { satisfaction in
                        Rectangle()
                            .fill(Color("\(satisfaction)Color"))
                            .frame(width: Double(fractions[Satisfaction.allCases.firstIndex(of: satisfaction)!]) * Double(width), height: 10)
                    }
                }
                .cornerRadius(10)
                
                HStack(spacing: 12) {
                    ForEach(Satisfaction.allCases, id: \.self) { satisfaction in
                        SatisfactionIndicator(satisfaction: satisfaction,
                                              percentage: fractions[Satisfaction.allCases.firstIndex(of: satisfaction)!] * 100,
                                              color: profile.selectedColor)
                    }
                }
            }
            
            Spacer()
    
            Text(recordManager.getLastRecordTeacher(game: game, student: profile) ?? "Nenhum registro")
            
            Button(action: {
                recordManager.viewRecordDetail(game: game)
            }) {
                Text("Acessar anotações")
                    .foregroundColor(recordManager.checkRecordsSaved(game: game, student: profile) ? .gray : .white )
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .frame(width: 246, height: 36)
                    .background(recordManager.checkRecordsSaved(game: game, student: profile) ? Color("neutralColor") : profile.selectedColor)
                    .cornerRadius(17)
            }
            .disabled(recordManager.checkRecordsSaved(game: game, student: profile))
            
            Spacer()
        }
        .blocked(!game.isAvailable())
    }
}

