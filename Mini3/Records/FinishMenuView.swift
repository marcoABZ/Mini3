//
//  FinishMenuView.swift
//  Mini3
//
//  Created by Pablo Penas on 19/11/21.
//

import SwiftUI

struct FinishMenuView: View {
    @EnvironmentObject var profileManager: ProfileManager
    @EnvironmentObject var recordManager: RecordManager
    @Binding var presented: Bool
    @Binding var shouldPopToRoot: Bool
//    @Binding var presentingSettings: Bool
    
    var body: some View {
        VStack {
            Text("Parabéns!")
                .font(.system(size: 34, design: .rounded).bold())
                .foregroundColor(.white)
            HStack {
                Text("Registrar esse jogo nos dados de")
                    .font(.system(size: 17, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Picker("Perfis", selection: $profileManager.editingIndex) {
                    ForEach(0..<profileManager.profiles.count) { index in
                        HStack {
                            Text(profileManager.profiles[index].name)
                                .tag(index)
                        }
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(profileManager.getEditingProfileColor())
                .padding(.leading, 20)
                .padding(.trailing, 40)
                .background(.white)
                .cornerRadius(20)
                .overlay(
                    Image(systemName: "chevron.down")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.gray)
                        .offset(x: 30)
                )
            }
            .onChange(of: profileManager.editingIndex) { newValue in
                profileManager.updateEditingProfile(index: newValue)
            }
            ZStack {
                profileManager.getFinishImage()
                profileManager.editingProfile.image
                    .resizable()
                    .frame(width: 180, height: 180)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.white, lineWidth: 2)
                    )
                    .offset(x: 120, y: -60)
            }
            HStack {
                Button(action: {
                    recordManager.updateViewMode()
                }) {
                    Text("Registrar atividade")
                        .foregroundColor(profileManager.getEditingProfileColor())
                }
                .frame(width: 220, height: 50)
                .background(.white)
                .cornerRadius(30)
                .padding()
                
                Button(action: { presented.toggle() }) {
                    Text("Jogar novamente")
                        .foregroundColor(.white)
                }
                .frame(width: 220, height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.white, lineWidth: 2)
                )
                .padding()
                
                Button(action: {
                    presented.toggle()
                    shouldPopToRoot.toggle()
                }) {
                    Text("Voltar para o início")
                        .foregroundColor(.white)
                }
                .frame(width: 220, height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.white, lineWidth: 2)
                )
                .padding()
            }
        }
    }
}

struct FinishMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ProfileManager().availableColors[0]
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.opacity(0.3), lineWidth: 5)
                )
                .ignoresSafeArea()
            FinishMenuView(presented: .constant(true), shouldPopToRoot: .constant(true))
                .environmentObject(RecordManager())
                .environmentObject(ProfileManager())
        }
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
