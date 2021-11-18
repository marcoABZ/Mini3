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
    
    var body: some View {
        VStack (spacing: 30) {
            HStack (alignment: .top){
                Image(systemName: "divide.circle")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .foregroundColor(student.getProfileColor())
                VStack (alignment: .leading) {
                    Text("Quantidade de divisoes")
                        .font(.system(size: 21, weight: .bold, design: .default))
                    
                    HStack {
                        Text("Divisões horizontais")
                        Spacer()
                        Button
                        { settings.horizontalDivision = max(1, settings.horizontalDivision - 1)
        //                            student.hd = settings.horizontalDivision
                            print(settings)
                        }
                            label: { Image(systemName: "minus.circle") }
                            .foregroundColor(settings.horizontalDivision > 1 ? student.getProfileColor() : .gray)
                            .disabled(settings.horizontalDivision <= 1)
                        
                    
                        Text(String(describing: settings.horizontalDivision))
                        
                        Button
                        { settings.horizontalDivision = min(10, settings.horizontalDivision + 1)
        //                            student.hd = settings.horizontalDivision
                            print(settings)
                        }
                            label: { Image(systemName: "plus.circle") }
                            .foregroundColor(settings.horizontalDivision < 10 ? student.getProfileColor() : .gray)
                            .disabled(settings.horizontalDivision >= 10)
                    }.padding([.top], 8)
                        
                    HStack {
                        Text("Divisões verticais")
                        Spacer()
                        Button
                        { settings.verticalDivision = max(1, settings.verticalDivision - 1)
        //                            student.vd = settings.verticalDivision
                            print(settings)
                        }
                            label: { Image(systemName: "minus.circle") }
                            .foregroundColor(settings.verticalDivision > 1 ? student.getProfileColor() : .gray)
                            .disabled(settings.verticalDivision <= 1)
                        
                    
                        Text(String(describing: settings.verticalDivision))
                        
                        Button
                        { settings.verticalDivision = min(10, settings.verticalDivision + 1)
        //                            student.vd = settings.verticalDivision
                            print(settings)
                        }
                            label: { Image(systemName: "plus.circle") }
                            .foregroundColor(settings.verticalDivision < 10 ? student.getProfileColor() : .gray)
                            .disabled(settings.verticalDivision >= 10)
                    }.padding(.top, 8)

                        
                }
                .font(.system(size: 17, weight: .medium, design: .default))
                
            }
            
            Divider()
            
            ToggleSettingView(iconName: "speaker.wave.2", title: "Efeitos sonoros", subtitle: "Sons de efeito realizados durante a interação.", controlledVariable: $settings.som)
            
            Divider()
            
            ToggleSettingView(iconName: "circle.grid.cross", title: "Retorno das peças", subtitle: "Permite que as peças retornem ao lugar inicial quando colocadas no lugar incorreto.", controlledVariable: $settings.voltarPeca)

            
            NavigationLink(destination: QuebraCabecaGameView(puzzleManager: PuzzleManager(settings: settings))) {
                Text("começar")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .frame(width: 240, height: 56)
                    .background(
                        Capsule()
                            .foregroundColor(student.getProfileColor())
                    )
            }
        }.navigationBarHidden(true)
    }
}
