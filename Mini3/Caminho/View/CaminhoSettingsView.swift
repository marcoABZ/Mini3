//
//  CaminhoSettingsView.swift
//  Mini3
//
//  Created by Ana C S Costa on 10/12/21.
//

import SwiftUI

struct CaminhoSettingsView: View {
    @EnvironmentObject var selectedProfileManager: SelectedProfileManager
    @EnvironmentObject var profileManager: ProfileManager
    @State var editingProfile: ProfileModel = ProfileManager.getDefaultProfile()
    @ObservedObject var settings: PuzzleConfiguration
    @State var sliderValue: Double = 3
    @State var pesonalizeSelected : Bool = false
    
    @State private var selectedLevel = Level.easy

    
    var body: some View {
        ZStack{
            editingProfile.selectedColor
            VStack{
                Text("Caminho")
                    .padding()
                    .foregroundColor(.white)
            
                RoundedRectangle(cornerRadius: 32)
                    .padding([.leading, .bottom, .trailing], 40.0)
                    .foregroundColor(.white)
            }
            HStack{
                VStack{
                    ZStack{
                    RoundedRectangle(cornerRadius: 24)
                        .frame(width: 440, height: 320, alignment: .leading)
                        .foregroundColor(editingProfile.selectedColor)
                        .opacity(0.3)

                        Button(action: {
                        }) {
                            Image(systemName: "arrow.counterclockwise")
                                .font(.system(size: 24).bold())
                                .foregroundColor(.white)
                        }
                        .frame(width: 80, height: 80)
                        .background(editingProfile.selectedColor)
                        .cornerRadius(40)
                        .padding(.leading, 380)
                        .padding(.top, 256)
                    }
                    
                    Picker("Flavor", selection: $selectedLevel) {
                        Text("Fácil")
                            .tag(Level.easy)
                        Text("Médio")
                            .tag(Level.medium)
                        Text("Difícil")
                            .tag(Level.hard)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 456, height: 48)
                    .onAppear {
                        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(editingProfile.selectedColor)
                    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(editingProfile.selectedColor)], for: .normal)
                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                    }
                    
                    Button(action: {
                        selectedLevel = .personalize
                        
                    }) {
                        Text("Personalize")
                            .font(.system(size: 17).bold())
                            .foregroundColor(.white)
                    }
                    .frame(width: 452, height: 44)
                    .background(selectedLevel == .personalize ? editingProfile.selectedColor : Color(.systemGray6))
                    .cornerRadius(30)
//                    .opacity(selectedLevel == .personalize ? 0.6 : 1)
                    
                }
                Divider()
                    .frame(width: 60, height: 500, alignment: .center)
                VStack(alignment: .leading){
                Text("Efeitos sonoros")
                        .font(.system(size: 24, weight: .bold, design: .rounded))

//                ToggleSettingView(iconName: "speaker.wave.2", title: "Efeitos sonoros", subtitle: "Sons de efeito realizados durante a interação.", controlledVariable: $settings.som)
                
                    
                    Divider()
                        .frame(width: 400, height: 60, alignment: .center)
                    
                    HStack (alignment: .top) {
                        Image(systemName: "scribble")
                            .font(.system(size: 21).bold())
                            .foregroundColor(editingProfile.selectedColor)
                        
                        VStack(alignment: .leading){
                        Text("Espessura do Caminho: \(sliderValue, specifier: "%.0f")")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        
                        Text("Escolha a grossura da linha que irá compor o caminho")
                            
                            Slider(value: $sliderValue, in: 1...5)
                                .padding(.bottom, 30)
                                .frame(width: 400, height: 60, alignment: .leading)
//                                .foregroundColor(selectedProfileManager.getProfileColor())
                        }
                    }
                    .padding(.vertical, 44.0)
                    

                    
                    
                    Button(action: {
                    }) {
                        Text("Começar")
                            .font(.system(size: 24).bold())
                            .foregroundColor(.white)
                    }
                    .frame(width: 240, height: 55, alignment: .center)
                    .background(editingProfile.selectedColor)
                    .cornerRadius(30)
                    .padding(.leading, 100.0)

                }
                
            }
        }
                .ignoresSafeArea()
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                HStack {
//                    Image(systemName: "arrow.left.circle")
//                        .font(.system(size: 28).bold())
//                    Text("voltar")
//                        .padding(.horizontal)
//                        .font(.system(size: 24).bold())
//                }
//                .foregroundColor(editingProfile.selectedColor)
//                .frame(width: 200, height: 55)
//                .background(.white)
//                .cornerRadius(30)
//                .onTapGesture {
//                    self.presentation.wrappedValue.dismiss()
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationTitle("Editar Perfil")
//        .background()
//        .ignoresSafeArea()
    }
}

struct CaminhoSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        CaminhoSettingsView(settings: PuzzleConfiguration())
.previewInterfaceOrientation(.landscapeLeft)
        
    }
}

enum Level: String, CaseIterable, Identifiable {
    case easy
    case medium
    case hard
    case personalize
    
    var id: String { self.rawValue }
}

