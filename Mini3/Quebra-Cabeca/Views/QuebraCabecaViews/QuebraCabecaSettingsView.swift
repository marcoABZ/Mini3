//
//  QuebraCabecaSettingsView.swift
//  Mini3
//
//  Created by Marco Zulian on 05/11/21.
//

import SwiftUI

struct QuebraCabecaSettingsView: View {
    @EnvironmentObject var student: ProfileManager
    @ObservedObject var settings: PuzzleConfiguration
    @State var isGameOn : Bool = false
    @State var letterOrderingAvailable: Bool = true
    @State var presenting: Bool = true
    @Binding var rootIsActive: Bool
    
    var body: some View {
        VStack (alignment: .center, spacing: 30) {
            VStack (alignment: .leading, spacing: 30) {
                HStack (alignment: .top){
                    Image(systemName: "divide.circle")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .foregroundColor(student.getProfileColor())
                    VStack (alignment: .leading, spacing: 5) {
                        Text("Quantidade de divisoes")
                            .font(.system(size: 21, weight: .bold, design: .default))
                        
                        HStack {
                            Text("Divisões horizontais")
                            Spacer()
                            Button
                                { settings.horizontalDivision = max(1, settings.horizontalDivision - 1)
                                    if settings.verticalDivision * settings.horizontalDivision <= 26 {
                                          withAnimation {
                                              letterOrderingAvailable = true
                                          }
                                    }
                                }
                                label: { Image(systemName: "minus.circle") }
                                .foregroundColor(settings.horizontalDivision > 1 ? student.getProfileColor() : .gray)
                                .disabled(settings.horizontalDivision <= 1)
                                .font(.system(size: 21, weight: .medium, design: .default))
                            
                        
                            Text(String(describing: settings.horizontalDivision))
                                .font(.system(size: 21, weight: .medium, design: .default))
                                .frame(width: 25)
                            
                            Button
                                { settings.horizontalDivision = min(10, settings.horizontalDivision + 1)
                                    if settings.verticalDivision * settings.horizontalDivision > 26 {
                                        if settings.ordenacao == .letter {
                                            settings.ordenacao = .none
                                        }
                                        withAnimation {
                                            letterOrderingAvailable = false
                                        }
                                    }
                                }
                                label: { Image(systemName: "plus.circle") }
                                .foregroundColor(settings.horizontalDivision < 10 ? student.getProfileColor() : .gray)
                                .disabled(settings.horizontalDivision >= 10)
                                .font(.system(size: 21, weight: .medium, design: .default))
                        }.padding(.top, 5)
                            
                        HStack {
                            Text("Divisões verticais")
                            Spacer()
                            Button
                                { settings.verticalDivision = max(1, settings.verticalDivision - 1)
                                  if settings.verticalDivision * settings.horizontalDivision <= 26 {
                                        withAnimation {
                                            letterOrderingAvailable = true
                                        }
                                  }
                                }
                                label: { Image(systemName: "minus.circle") }
                                .foregroundColor(settings.verticalDivision > 1 ? student.getProfileColor() : .gray)
                                .disabled(settings.verticalDivision <= 1)
                                .font(.system(size: 21, weight: .medium, design: .default))
                            
                        
                            Text(String(describing: settings.verticalDivision))
                                .font(.system(size: 21, weight: .medium, design: .default))
                                .frame(width: 25)
                            
                            Button
                                { settings.verticalDivision = min(10, settings.verticalDivision + 1)
                                    if settings.verticalDivision * settings.horizontalDivision > 26 {
                                        if settings.ordenacao == .letter {
                                            settings.ordenacao = .none
                                        }
                                        withAnimation {
                                            letterOrderingAvailable = false
                                        }
                                    }
                                }
                                label: { Image(systemName: "plus.circle") }
                                .foregroundColor(settings.verticalDivision < 10 ? student.getProfileColor() : .gray)
                                .disabled(settings.verticalDivision >= 10)
                                .font(.system(size: 21, weight: .medium, design: .default))
                        }

                            
                    }
                    .font(.system(size: 17, weight: .medium, design: .default))
                    
                }
                
                Divider()
                
                ToggleSettingView(iconName: "speaker.wave.2", title: "Efeitos sonoros", subtitle: "Sons de efeito realizados durante a interação.", controlledVariable: $settings.som)
                
                Divider()
                
                ToggleSettingView(iconName: "circle.grid.cross", title: "Retorno das peças", subtitle: "Permite que as peças retornem ao lugar inicial quando colocadas no lugar incorreto.", controlledVariable: $settings.voltarPeca)

                Divider()
                
                HStack (alignment: .top){
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .foregroundColor(student.getProfileColor())
                    HStack (alignment: .center) {
                        VStack (alignment: .leading, spacing: 5) {
                            Text("Incluir ordenação")
                                .font(.system(size: 21, weight: .bold, design: .default))
                            Text("Cada pedaço da imagem poderá receber uma letra ou número organizados em ordem.")
                                .font(.system(size: 14, weight: .regular, design: .default))
                                .foregroundColor(.gray)
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                        }
                        Spacer()
                        Button
                            { settings.ordenacao = .none }
                            label: { Text("X")
                                    .font(.system(size: 32, weight: .bold, design: .default))
                                    .foregroundColor(settings.ordenacao == .none ? .white : .black)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .addBorder(Color(uiColor: .systemGray3), width: settings.ordenacao == .none ? 0 : 2, cornerRadius: 8)
                                            .foregroundColor(settings.ordenacao == .none ? student.getProfileColor() : Color(uiColor: .systemGray5))
                                    )
                            }
                        
                        if (letterOrderingAvailable) {
                        Button
                            { settings.ordenacao = .letter }
                            label: { Text("A")
                                    .font(.system(size: 32, weight: .bold, design: .default))
                                    .foregroundColor(settings.ordenacao == .letter ? .white : .black)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .addBorder(Color(uiColor: .systemGray3), width: settings.ordenacao == .letter ? 0 : 2, cornerRadius: 8)
                                            .foregroundColor(settings.ordenacao == .letter ? student.getProfileColor() : Color(uiColor: .systemGray5))
                                    )
                            }
                            .disabled(settings.horizontalDivision * settings.verticalDivision > 26)
//                            .if(settings.horizontalDivision * settings.verticalDivision > 26) {v in
//                                v.opacity(0.5)
//                            }
                        }
                        
                        Button
                            { settings.ordenacao = .number }
                            label: { Text("1")
                                    .font(.system(size: 32, weight: .bold, design: .default))
                                    .foregroundColor(settings.ordenacao == .number ? .white : .black)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .addBorder(Color(uiColor: .systemGray3), width: settings.ordenacao == .number ? 0 : 2, cornerRadius: 8)
                                            .foregroundColor(settings.ordenacao == .number ? student.getProfileColor() : Color(uiColor: .systemGray5))
                                    )
                            }
                        
                    }
                }
            }
                
            
            NavigationLink(destination: QuebraCabecaGameView(puzzleManager: PuzzleManager(settings: settings)
                                                             ,presentingSettings: $presenting,
                                                             shouldPopToRoot: $rootIsActive
                                                            )) {
                Text("Começar")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .frame(width: 240, height: 56)
                    .background(
                        Capsule()
                            .foregroundColor(student.getProfileColor())
                    )
            }
            .isDetailLink(false)
        }.navigationBarHidden(true)
//        .onChange(of: presenting) { _ in presentationMode.wrappedValue.dismiss() }
    }
}
