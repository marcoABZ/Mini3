//
//  FinishMenuView.swift
//  Mini3
//
//  Created by Pablo Penas on 19/11/21.
//

import SwiftUI

struct FinishMenuView: View {
    @EnvironmentObject var selectedProfileManager: SelectedProfileManager
    @EnvironmentObject var profileManager: ProfileManager
    @EnvironmentObject var recordManager: RecordManager
    @Binding var presented: Bool
    @Binding var shouldPopToRoot: Bool
    @State var selectedProfile: UUID
    
    //Animation:
    @State var opacity = 0.0
    
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
                Picker(selection: $selectedProfile, label: Text("")) {
                    ForEach(profileManager.profiles) { prof in
                        HStack {
                            Text(prof.name)
                                .tag(prof.id)
                        }
                    }
                }
                .id(UUID())
                .pickerStyle(MenuPickerStyle())
                .accentColor(selectedProfileManager.getProfileColor())
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

            ZStack {
                selectedProfileManager.getFinishImage()
                selectedProfileManager.getImage()
                    .resizable()
                    .frame(width: 180, height: 180)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.white, lineWidth: 2)
                    )
                    .offset(x: 120, y: -60)
            }
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 2.5)) {
                    opacity += 1
                }
            }
            HStack {
                Button(action: {
                    recordManager.updateViewMode()
                }) {
                    Text("Registrar atividade")
                        .foregroundColor(selectedProfileManager.getProfileColor())
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
        }.onChange(of: selectedProfile, perform: {newValue in selectedProfileManager.setSelectedProfile(profile: profileManager.profiles.first { $0.id == selectedProfile }!)})
    }
}
