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
    @State var selectedProfile: ProfileModel
    
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
                Button(action: {
                    recordManager.returnToView()
                }) {
                    Text("Voltar")
                        .font(.system(size: 17, weight: .bold))
                        .frame(width: 220, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(.white.opacity(0.5), lineWidth: 2)
                        )
                }
                
                
                Button(action: {
                    recordManager.registerTeacher()
                }) {
                    Text("Registrar professor")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color(selectedProfile.selectedColor))
                        .frame(width: 220, height: 50)
                        .background(.white)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(.white.opacity(0.5), lineWidth: 2)
                        )
                }
                .disabled(recordManager.addingTeacher.isEmpty)
            }
            Spacer()
        }
        .foregroundColor(.white)
    }
}

struct ManageTeacherView: View {
    @EnvironmentObject var recordManager: RecordManager
    @EnvironmentObject var profileManager: ProfileManager
    @State var selectedProfile: ProfileModel
    
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
                ForEach(recordManager.registeredTeachers, id: \.self) { teacher in
                    VStack {
                        HStack {
                            if recordManager.selectedTeacher.nome == teacher.nome {
                                Image(systemName: "checkmark.seal.fill")
                            }
                            Text(" Prof. \(teacher.nome)")
                                .onTapGesture {
                                    recordManager.selectedTeacher = teacher
                                }
                            Spacer()

                            Image(systemName: "trash")
                                .onTapGesture {
                                    recordManager.eraseTeacher(teacher: teacher)
                                }

                        }
                        .font(.system(size: 17, design: .rounded).bold())
                        .padding()
                        
                        Path { path in
                            path.move(to: CGPoint(x: 17, y: 0))
                            path.addLine(to: CGPoint(x: 790, y: 0))
                        }
                        .stroke(Color(selectedProfile.selectedColor), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                        .frame(height: 3)
                    }
                }
                .listRowBackground(Color.white.opacity(0))
                
            }
            .listStyle(PlainListStyle())
            .background(
                Color(selectedProfile.selectedColor).overlay(Color.black.opacity(0.2))
            )
            .cornerRadius(24)
            .frame(maxHeight: 250)
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
                Button(action: {
                    recordManager.returnToView()
                }) {
                    Text("Voltar")
                        .font(.system(size: 17, weight: .bold))
                        .frame(width: 220, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(.white.opacity(0.5), lineWidth: 2)
                        )
                }
                
                Button(action: {
                    recordManager.registerTeacher()
                }) {
                    Text("Registrar professor")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color(selectedProfile.selectedColor))
                        .frame(width: 220, height: 50)
                        .background(.white)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(.white.opacity(0.5), lineWidth: 2)
                        )
                }
                .disabled(recordManager.addingTeacher.isEmpty)
            }
            .padding(.top, 24)

        }
        .frame(width: 840)
        .foregroundColor(.white)
    }
}

struct TeacherRegisterView: View {
    @EnvironmentObject var recordManager: RecordManager
    @EnvironmentObject var selectedProfileManager: SelectedProfileManager
    
    var body: some View {
        if recordManager.registeredTeachers.count == 0 {
            AddTeacherView(selectedProfile: selectedProfileManager.getProfile())
        } else {
            ManageTeacherView(selectedProfile: selectedProfileManager.getProfile())
        }
    }
}
