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
    @Binding var presented: Bool
    @Binding var shouldPopToRoot: Bool
    @State var selectedProfile: ProfileModel

//    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack {
            HStack {
                Text("Como foi, Prof. \(recordManager.selectedTeacher.nome)?")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                Spacer()
                Button(action: {
                    recordManager.editTeacher()
                }) {
                    HStack {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        Text("Editar professor(a)")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding(.horizontal)
                    }
                    .foregroundColor(selectedProfile.selectedColor)
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
                TextEditor(text: $recordManager.editingRecord.annotation)
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
                        .foregroundColor(selectedProfile.selectedColor)
                        .font(.system(size: 30))
                        .frame(width: 92, height: 92)
                        .background(.white)
                        .cornerRadius(24)
                }
                .disabled(true)
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
                    recordManager.saveRecord(student: selectedProfile)
                    presented.toggle()
                    shouldPopToRoot.toggle()
//                    profileManager.unwindToDashboard = false
                }) {
                    Text("Salvar informações")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(selectedProfile.selectedColor)
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
            Button(action: {
                recordManager.editingRecord.satisfaction = .overSatisfied
            }) {
                Image(recordManager.editingRecord.satisfaction == .overSatisfied ? "overSatisfiedColored" : "overSatisfied")
                    .shadow(color: recordManager.editingRecord.satisfaction == .overSatisfied ? .black.opacity(0.2) : .clear, radius: 10, x: 0, y: 4)
            }
            Button(action: {
                recordManager.editingRecord.satisfaction = .satisfied
            }) {
                Image(recordManager.editingRecord.satisfaction == .satisfied ? "satisfiedColored" : "satisfied")
                    .shadow(color: recordManager.editingRecord.satisfaction == .satisfied ? .black.opacity(0.2) : .clear, radius: 10, x: 0, y: 4)
            }
            Button(action: {
                recordManager.editingRecord.satisfaction = .notSatisfied
            }) {
                Image(recordManager.editingRecord.satisfaction == .notSatisfied ? "notSatisfiedColored" : "notSatisfied")
                    .shadow(color: recordManager.editingRecord.satisfaction == .notSatisfied ? .black.opacity(0.2) : .clear, radius: 10, x: 0, y: 4)
            }
        }
    }
}