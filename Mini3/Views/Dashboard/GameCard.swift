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
    
    @Binding var allFaceUp: Bool
    @State var isFaceUp: Bool = true
    
    @EnvironmentObject var recordManager: RecordManager
    @EnvironmentObject var selectedProfileManager: SelectedProfileManager
    @Binding var isActive: Bool
    @Binding var hasSidebar: Bool
    
    @State var fractions: [Float]
    let width = 254
    
    
    var body: some View {
        VStack {
            backFace
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation { isFaceUp.toggle() }
                }
        }
        .cardify(isFaceUp: isFaceUp, background: AnyView(frontFace))
        .onChange(of: allFaceUp, perform: { _ in
            withAnimation { isFaceUp = allFaceUp }
        })
        .padding(.leading)
    }
    
    var frontFace: some View {
        //TODO: Generalizar para mais jogos - provavelmente vai precisar de um @ViewBuilder
        ZStack(alignment: .bottomTrailing) {
            NavigationLink(
                destination:
                    QuebraCabecaStartView(
                        puzzleManager: PuzzleManager(settings: PuzzleConfiguration()),
                        rootIsActive: $isActive)
                    .environmentObject(selectedProfileManager),
                isActive: $isActive
            ) {
                    Image(game.getCoverImage(mascote: mascote))
                            .resizable()
                            .cornerRadius(16)
                            .aspectRatio(contentMode: .fit)
                            .blocked(!game.isAvailable())
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
            
            Button(action: {
                withAnimation() {
                    isFaceUp.toggle()
                }
            })
            {
                Image(systemName: "info.circle")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .semibold, design: .default))
                    .padding()
            }

        }
    }
    
    var backFace: some View {
        VStack {
            Image(Mascotes.getCardCoverImages(animal: mascote, jogo: game))
                .resizable()
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .aspectRatio(contentMode: .fit)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Jogo \(game.rawValue)")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .padding(.top)
                    Text(recordManager.getLastRecordDate(game: game, student: profile) ?? "Nenhum registro")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                    Text(game.getDescription())
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
                                              color: selectedProfileManager.getProfileColor())
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                recordManager.viewRecordDetail(game: game)
            }) {
                Text("Acessar anotações")
                    .foregroundColor(recordManager.checkRecordsSaved(game: game, student: profile) ? .gray : .white )
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .frame(width: 246, height: 36)
                    .background(recordManager.checkRecordsSaved(game: game, student: profile) ? Color("neutralColor") : selectedProfileManager.getProfileColor())
                    .cornerRadius(17)
            }
            .disabled(recordManager.checkRecordsSaved(game: game, student: profile))
            
            Spacer()
        }
        .blocked(!game.isAvailable())
    }
}

struct GameCard_Preview: PreviewProvider {

    static var previews: some View {
        GameCard(game: .quebraCabeca, mascote: .chiba, profile: ProfileManager().profiles[0], allFaceUp: .constant(true), isActive: .constant(true), hasSidebar: .constant(false), fractions: [])
    }
}
