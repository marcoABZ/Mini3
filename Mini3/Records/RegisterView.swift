//
//  RegisterView.swift
//  Mini3
//
//  Created by Pablo Penas on 19/11/21.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var recordManager: RecordManager
    @EnvironmentObject var profileManager: ProfileManager
    var body: some View {
        VStack {
            HStack {
                Text("Como foi, Prof. Márcia?")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                Spacer()
                Button(action: {}) {
                    HStack {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        Text("Editar professor(a)")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding(.horizontal)
                    }
                    .foregroundColor(profileManager.availableColors[0])
                    .frame(width: 260, height: 50)
                    .background(.white)
                    .cornerRadius(25)
                }
            }
            HStack {
                Text("Geral")
                    .font(.system(size: 21, weight: .bold, design: .rounded))
                    .padding(.trailing,24)
                makeFacesView()
                Spacer()
            }
            HStack {
                Text("Anotações")
                    .font(.system(size: 21, weight: .bold, design: .rounded))
                Spacer()
            }
            .padding(.top, 60)
            HStack(alignment: .top, spacing: 22) {
                TextEditor(text: $recordManager.addingTeacher)
                    .padding()
                    .placeholder(when: recordManager.addingTeacher.isEmpty) {
                        Text("Descreva com mais detalhes sobre a experiência.")
                            .foregroundColor(.white)
                            .padding(.leading,20)
                            .offset(y: -100)
                    }
                    .frame(height: 280, alignment: .top)
                    .background(.black.opacity(0.2))
                    .cornerRadius(24)
                
                Button(action: {}) {
                    Image(systemName: "mic.fill")
                        .foregroundColor(profileManager.availableColors[0])
                        .font(.system(size: 30))
                        .frame(width: 92, height: 92)
                        .background(.white)
                        .cornerRadius(24)
                }
            }
            HStack(spacing: 30) {
                Button(action: {}) {
                    Text("Voltar")
                        .font(.system(size: 17, weight: .bold))
                        .frame(width: 220, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(.white.opacity(0.5), lineWidth: 2)
                        )
                }
                
                Button(action: {}) {
                    Text("Salvar informações")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(profileManager.getProfileColor())
                        .frame(width: 220, height: 50)
                        .background(.white)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(.white.opacity(0.5), lineWidth: 2)
                        )
                }
            }
            .padding(.top, 30)
        }
        .padding(36)
        .foregroundColor(.white)
        .onAppear {
            UITextView.appearance().backgroundColor = .clear
        }
    }
    
    func makeFacesView() -> some View {
        return HStack(spacing: 16) {
            Image("overSatisfied")
            Image("satisfied")
            Image("notSatisfied")
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ProfileManager().availableColors[0]
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.opacity(0.3), lineWidth: 5)
                )
                .ignoresSafeArea()
            RegisterView()
                .environmentObject(RecordManager())
                .environmentObject(ProfileManager())
        }
        .previewInterfaceOrientation(.landscapeLeft)
        
    }
}
