//
//  ProfileView.swift
//  Mini3
//
//  Created by Pablo Penas on 10/11/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var profileManager: ProfileManager
    @EnvironmentObject var dashboardManager: DashboardManager
    @Environment(\.presentationMode) var presentation
    
    //Apagar
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var showingAlert = false
    @State private var inputImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    
    var body: some View {
        profileManager.editingProfile.selectedColor
            .ignoresSafeArea(.all)
            .overlay {
                HStack {
                    
                    LeftPannelView()
                    
                    VStack {
                        Spacer()
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            path.addLine(to: CGPoint(x: 0, y: 560))
                            
                        }
                        .stroke(profileManager.editingProfile.selectedColor, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                        .frame(width: 3, height: 560)
                        Spacer()
                    }
                    
                    RightPannelView()
                }
                .background()
                .cornerRadius(32)
                .frame(maxHeight: 640)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "arrow.left.circle")
                            .font(.system(size: 28).bold())
                        Text("voltar")
                            .padding(.horizontal)
                            .font(.system(size: 24).bold())
                    }
                    .foregroundColor(profileManager.editingProfile.selectedColor)
                    .frame(width: 200, height: 55)
                    .background(.white)
                    .cornerRadius(30)
                    .onTapGesture {
                        self.presentation.wrappedValue.dismiss()
//                        profileManager.editingProfile = profileManager.selectedProfile!
//                        profileManager.addingProfile = false
//                        profileManager.isEditingProfile = false
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(profileManager.addingProfile ? "Novo Perfil" : "Editar Perfil")
            .onDisappear() {
                profileManager.editingProfile = ProfileModel(name: "", birthdate: Date(), color: Color("noColor"), image: "placeholder")
            }
            .ignoresSafeArea()
    }

}
