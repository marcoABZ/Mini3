//
//  DesempenhoView.swift
//  Mini3
//
//  Created by Marco Zulian on 17/11/21.
//

import SwiftUI

struct SatisfactionView: View {
    @EnvironmentObject var profileManager: ProfileManager
    
    let fractions: [Float]
    let width = 254
    var body: some View {
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
                    HStack {
                        
                        Image("\(satisfaction)Colored")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .background(Color("satisfactionGray"))
                            .cornerRadius(12)
                        Text("\(fractions[Satisfaction.allCases.firstIndex(of: satisfaction)!] * 100, specifier: "%.f")%")
                    }
                    .frame(width: 80, height: 36)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(profileManager.getProfileColor(), lineWidth: 2)
                    )
                }
            }
            .padding(.vertical, 30)
        }
    }
}

struct DesempenhoView: View {
    
    @EnvironmentObject var dashboardManager: DashboardManager
    @EnvironmentObject var profileManager: ProfileManager
    @EnvironmentObject var recordManager: RecordManager
    
    //Apagar animacao e variavel abaixo
    @State var pct: Double = 0.0
    
    var body: some View {
        VStack {
            Text("Registro dos jogos")
                .font(.system(size: 24, weight: .bold, design: .rounded))
            
            ScrollView(.horizontal) {
                HStack(spacing: 24) {
                    ForEach(Game.allCases, id: \.self) { game in
                        createCardViews(jogo: game)
                    }
                }
                .padding(40)
            }
        }
    }
    
    func createCardViews(jogo: Game) -> some View {
        return VStack {
            Image(Mascotes.getCardCoverImages(animal: profileManager.selectedProfile!.mascote, jogo: jogo))
            HStack {
                VStack(alignment: .leading) {
                    Text("Jogo \(jogo.rawValue)")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                    Text(recordManager.getLastRecordDate(game: jogo) ?? "Nenhum registro")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                }
                Spacer()
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 22)
            
            SatisfactionView(fractions: recordManager.getSatisfactionRates(jogo: jogo))
    
            Text(recordManager.getLastRecordTeacher(game: jogo) ?? "Nenhum registro")
            Button(action: {}) {
                Text("Acessar anotações")
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .frame(width: 246, height: 36)
                    .background(profileManager.getProfileColor())
                    .cornerRadius(17)
            }
            .padding(.vertical, 30)
            .disabled(recordManager.checkRecordsSaved(game: jogo))
        }
        .cornerRadius(24)
        .background(
            RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white)
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 4)
        )
        .frame(width: 300)
        
    }
    
}

struct DesempenhoView_Previews: PreviewProvider {
    static var previews: some View {
        DesempenhoView()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(ProfileManager())
            .environmentObject(DashboardManager())
            .environmentObject(RecordManager())
    }
}
