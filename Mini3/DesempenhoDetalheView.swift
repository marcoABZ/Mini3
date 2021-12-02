//
//  DesempenhoDetalheView.swift
//  Mini3
//
//  Created by Pablo Penas on 24/11/21.
//

import SwiftUI

struct DesempenhoDetalheView: View {
    @EnvironmentObject var selectedProfileManager: SelectedProfileManager
    @EnvironmentObject var recordManager: RecordManager
    
    
    var body: some View {
        VStack {
            ZStack {
                Text("Jogo \(recordManager.currentGame.rawValue)")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(selectedProfileManager.getProfileColor())
                HStack {
                    Button(action: {
                        recordManager.detailSheetShowing = false
                    }) {
                        Image(systemName: "arrow.left.circle")
                            .font(.system(size: 34))
                            .foregroundColor(selectedProfileManager.getProfileColor())
                    }
                    Spacer()
                }
            }
            .padding(.bottom, 40)
            HStack {
                Text("Classificações médias")
                    .font(.system(size: 21, weight: .semibold, design: .rounded))
                Spacer()
            }
            HStack {
                HStack(spacing: 5) {
                    ForEach(Satisfaction.allCases, id: \.self) { satisfaction in
                        HStack {
                            
                            Image("\(satisfaction)Colored")
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("\(recordManager.getSatisfactionRates(jogo: recordManager.currentGame, student: selectedProfileManager.getProfile())[Satisfaction.allCases.firstIndex(of: satisfaction)!] * 100, specifier: "%.f")%")
                                .foregroundColor(.white)
                        }
                        .frame(width: 80, height: 36)
                        .background(selectedProfileManager.getProfileColor())
                        .cornerRadius(8)
                    }
                }
                Text("Melhora de \(Text("23%").foregroundColor(selectedProfileManager.getProfileColor())) comparada ao último jogo")
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .padding(.leading, 30)
                Spacer()
            }
            .padding(.vertical,28)
            RoundedRectangle(cornerRadius: 5)
                .fill(Color("lightGray"))
                .frame(height: 5)
            
            HStack {
                Text("Relatório dos jogos:")
                    .font(.system(size: 21, weight: .semibold, design: .rounded))
                Spacer()
            }
            
            ScrollView(.vertical) {
                VStack {
                    ForEach(recordManager.getRecordByGame(game: recordManager.currentGame, student: selectedProfileManager.getProfile()), id: \.self) { record in
                        VStack(spacing: 0) {
                            HStack(alignment: .center) {
                                Text("Relatório \(recordManager.getRecordIndex(record: record, student: selectedProfileManager.getProfile())) | Prof.(a): \(record.teacher.nome) | \(Text("\(recordManager.dateToString(date: record.dateSaved))").fontWeight(.regular))")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                                    .padding()
                                    .padding(.trailing, 300)
                                    .onTapGesture {
                                        if recordManager.selectedRecordId == record.id {
                                            recordManager.selectedRecordId = UUID()
                                        } else {
                                            recordManager.selectedRecordId = record.id
                                        }
                                    }
                                Spacer()
                                
                                Image("\(record.satisfaction)Colored")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .padding(.horizontal)
                                
                                Image(systemName: "trash")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .bold))
                                    .padding(.trailing)
                                    .padding(.bottom,2)
                                    .onTapGesture {
                                        recordManager.eraseRecord(record: record)
                                    }
                                
                            }
                            .background(selectedProfileManager.getProfileColor())
                            .cornerRadius(16)
                            
                            if record.id == recordManager.selectedRecordId && !record.annotation.isEmpty {
                                VStack(alignment: .leading) {
                                    Text("Anotações")
                                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                                    Text(record.annotation)
                                        .font(.system(size: 14, design: .rounded))
                                    HStack(spacing: 24) {
                                        Spacer()
                                        Button(action: {
//                                            UIPasteboard.general.string = record.annotation
                                        }) {
                                            Image(systemName: "doc.on.doc")
                                        }
                                        Button(action: {
//                                            let sharedImage = Text(record.annotation).snapshot()
//                                            actionSheet(image: sharedImage)
                                        }) {
                                            Image(systemName: "square.and.arrow.up")
                                        }
                                    }
                                    .padding(.top, 12)
                                    .foregroundColor(selectedProfileManager.getProfileColor())
                                    .font(.system(size: 17, weight: .bold))
                                }
                                .padding(20)
                                .padding(.top, 30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(selectedProfileManager.getProfileColor(), lineWidth: 2)
                                )
                                .offset(y: -40)
                            }
                        }
                    }
                }
            }
        }
        .padding(40)
    }
    
    func actionSheet(image: UIImage) {
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        activityVC.isModalInPresentation = true
    }
}

struct DesempenhoDetalheView_Previews: PreviewProvider {
    static var previews: some View {
        DesempenhoDetalheView()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(RecordManager())
            .environmentObject(ProfileManager())
    }
}
