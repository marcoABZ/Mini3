//
//  FinishMenuView.swift
//  Mini3
//
//  Created by Pablo Penas on 19/11/21.
//

import SwiftUI

struct FinishMenuView: View {
    @EnvironmentObject var profileManager: ProfileManager
    @State var registeringProfile: ProfileModel = ProfileModel(name: "", birthdate: Date(), color: .black, image: "") {
        willSet {
            updateProfile()
        }
    }
    @State var savingProfile = 1
    
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
                Picker("Perfis", selection: $profileManager.selectedProfile) {
                    ForEach(0..<profileManager.profiles.count) { index in
                        Text(profileManager.profiles[index].name)
                            .tag(profileManager.profiles[index])
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.horizontal,25)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.white, lineWidth: 2)
                        .frame(width: 70, height: 30)
                )
                .accentColor(.white)
            }
            ZStack {
                profileManager.getFinishImage()
                profileManager.selectedProfile!.image
                    .resizable()
                    .frame(width: 180, height: 180)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.white, lineWidth: 2)
                    )
                    .offset(x: 120, y: -60)
            }
            HStack {
                Button(action: {}) {
                    Text("Registrar atividade")
                        .foregroundColor(.purple)
                }
                .frame(width: 220, height: 50)
                .background(.white)
                .cornerRadius(30)
                .padding()
                
                Button(action: {}) {
                    Text("Jogar novamente")
                        .foregroundColor(.white)
                }
                .frame(width: 220, height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.white, lineWidth: 2)
                )
                .padding()
                
                Button(action: {}) {
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
        .onAppear {
            registeringProfile = profileManager.selectedProfile!
        }
    }
    
    func updateProfile() {
        profileManager.selectedProfile = registeringProfile
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
            FinishMenuView()
                .environmentObject(ProfileManager())
        }
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
