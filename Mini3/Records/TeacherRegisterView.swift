//
//  TeacherRegisterView.swift
//  Mini3
//
//  Created by Pablo Penas on 19/11/21.
//

import SwiftUI

struct AddTeacherView: View {
    @EnvironmentObject var recordManager: RecordManager
    @EnvironmentObject var profileManager: ProfileManager
    var body: some View {
        VStack {
            Spacer()
            Text("Parece que ainda não temos um professor registrado")
                .font(.system(size: 34, design: .rounded).bold())
                .multilineTextAlignment(.center)
                .padding(.bottom,24)
            Text("O nome do professor será registrado junto com o registro da atividade para poder acessar quem realizou o registro de cada observação.")
                .multilineTextAlignment(.center)
                .frame(width: 792)
            
            Text("Seu nome:")
                .font(.system(size: 34, design: .rounded).bold())
                .padding(.top, 50)
            TextField("", text: $recordManager.addingTeacher)
                .padding()
                .frame(width: 792)
                .background(.black.opacity(0.2))
                .cornerRadius(24)
                .placeholder(when: recordManager.addingTeacher.isEmpty) {
                    Text("Escreva seu nome aqui")
                        .foregroundColor(.white)
                        .padding(.leading,20)
                }
            Spacer()
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
                    Text("Registrar professor")
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
            Spacer()
        }
        .foregroundColor(.white)
    }
}

struct ManageTeacherView: View {
    @EnvironmentObject var recordManager: RecordManager
    @EnvironmentObject var profileManager: ProfileManager
    var body: some View {
        VStack {
            Text("Registro de professores")
                .font(.system(size: 34, design: .rounded).bold())
                .multilineTextAlignment(.center)
            .padding(.bottom,24)
            
            HStack {
                Text("Lista de professores:")
                    .font(.system(size: 24, design: .rounded).bold())
                Spacer()
            }
            List {
                ForEach(0..<recordManager.registeredTeachers.count) { index in
                    VStack {
                        HStack {
                            Text("\(recordManager.registeredTeachers[index].nome)")
                            Spacer()
                            Button(action: {}) {
                                Image(systemName: "trash")
                            }
                        }
                        .font(.system(size: 17, design: .rounded).bold())
                        .padding()
                        Path { path in
                            path.move(to: CGPoint(x: 17, y: 0))
                            path.addLine(to: CGPoint(x: 790, y: 0))
                        }
                        .stroke(profileManager.availableColors[0], style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                        .frame(height: 3)
                    }
                }
                .listRowBackground(Color.white.opacity(0))
                
            }
            .listStyle(PlainListStyle())
            .background(
                profileManager.availableColors[0].overlay(Color.black.opacity(0.2))
            )
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(.white.opacity(0.5), lineWidth: 2)
            )
            HStack {
                Text("Novo perfil:")
                    .font(.system(size: 24, design: .rounded).bold())
                Spacer()
            }
            .padding(.top, 28)
            TextField("", text: $recordManager.addingTeacher)
                .padding()
                .background(.black.opacity(0.2))
                .cornerRadius(24)
                .placeholder(when: recordManager.addingTeacher.isEmpty) {
                    Text("Escreva seu nome aqui")
                        .foregroundColor(.white)
                        .padding(.leading,20)
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
                    Text("Registrar professor")
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
            .padding(.top, 24)

        }
        .frame(width: 840)
        .foregroundColor(.white)
    }
}

struct TeacherRegisterView: View {
    @EnvironmentObject var recordManager: RecordManager
    @EnvironmentObject var profileManager: ProfileManager
    var body: some View {
        if recordManager.registeredTeachers.count == 0 {
            AddTeacherView()
                .environmentObject(recordManager)
                .environmentObject(profileManager)
        } else {
            ManageTeacherView()
                .environmentObject(recordManager)
                .environmentObject(profileManager)
        }
    }
}

struct TeacherRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ProfileManager().availableColors[0]
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.opacity(0.3), lineWidth: 5)
                )
                .ignoresSafeArea()
            TeacherRegisterView()
                .environmentObject(RecordManager())
                .environmentObject(ProfileManager())
        }
        .previewInterfaceOrientation(.landscapeLeft)
        
    }
}