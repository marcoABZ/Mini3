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
    @State var editingProfile: ProfileModel = ProfileManager.getDefaultProfile()
    
    //Apagar
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var showingAlert = false
    @State private var inputImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    
    var body: some View {
        ZStack {
            editingProfile.selectedColor
                .ignoresSafeArea(.all)
            HStack {
                
                LeftPannelView(editingProfile: $editingProfile)
                
                VStack {
                    Spacer()
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: 0, y: 560))
                        
                    }
                    .stroke(editingProfile.selectedColor, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    .frame(width: 3, height: 560)
                    Spacer()
                }
                
                RightPannelView(editingProfile: $editingProfile)
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
                .foregroundColor(editingProfile.selectedColor)
                .frame(width: 200, height: 55)
                .background(.white)
                .cornerRadius(30)
                .onTapGesture {
                    profileManager.dismissProfileView()
                    self.presentation.wrappedValue.dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(profileManager.addingProfile ? "Novo Perfil" : "Editar Perfil")
        .background()
        .ignoresSafeArea()
    }

}
