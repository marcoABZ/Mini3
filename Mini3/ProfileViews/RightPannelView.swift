//
//  RightPannelView.swift
//  Mini3
//
//  Created by Marco Zulian on 23/11/21.
//

import SwiftUI

struct RightPannelView: View {
    
    @EnvironmentObject var profileManager: ProfileManager
    @EnvironmentObject var dashboardManager: DashboardManager
    @Environment(\.presentationMode) var presentation

    @State private var image: Image?
    
    var body: some View {
        
        let im: Image? = image ?? profileManager.editingProfile.image
        
        VStack {
            VStack(alignment: .leading) {
                Text("Nome")
                TextField("Nome", text: $profileManager.editingProfile.name)
                    .font(.system(size: 21, weight: .regular, design: .rounded))
                    .padding(.leading)
                    .padding(12)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                
                DatePicker("Data de Nascimento", selection: $profileManager.editingProfile.birthdate, in: ...Date(), displayedComponents: .date)
                    .padding(.top, 24)
                
                Text("Escolher Mascote")
                    .padding(.top, 24)
                HStack(spacing: 35) {
                    Spacer()
                    ForEach(0..<Mascotes.allCases.count) { i in
                        Button(action: {
                            profileManager.editingProfile.mascote = Mascotes.allCases[i]
                        }) {
                            Image(Mascotes.getImageIconName(animal: Mascotes.allCases[i]))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 94, height: 94)
                                .foregroundColor(.gray.opacity(0.2))
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 19)
                                        .stroke(profileManager.editingProfile.selectedColor, lineWidth: profileManager.editingProfile.mascote == Mascotes.allCases[i] ? 8 : 0)
                                        .frame(width: 100, height: 100)
                                )
                        }
                    }
                }
                
                Toggle("Modo escuro", isOn: $profileManager.editingProfile.darkModeEnabled)
                    .padding(.top, 24)
                    .toggleStyle(SwitchToggleStyle(tint: profileManager.editingProfile.selectedColor))
                
            }
            .font(.system(size: 24, weight: .bold, design: .rounded))
            

            Button(action: {
                profileManager.saveProfile(image: im!)
                dashboardManager.getGamesAvailable(mascote: profileManager.selectedProfile!.mascote)
                presentation.wrappedValue.dismiss()
            }) {
                Text(profileManager.addingProfile ? "Criar" : "Salvar")
                    .font(.system(size: 24).bold())
                    .foregroundColor(.white)
            }
            .frame(width: 240, height: 55)
            .background(profileManager.editingProfile.selectedColor)
            .cornerRadius(30)
            .padding(.top,42)
        }
        .padding(.trailing, 80)
        .padding(.leading, 36)
        .frame(maxWidth: 492)
    }
}
