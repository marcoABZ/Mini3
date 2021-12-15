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
            Color(editingProfile.selectedColor)
                .ignoresSafeArea(.all)
            HStack {
                
                LeftPannelView(editingProfile: $editingProfile)
                
                VStack {
                    Spacer()
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: 0, y: 560))
                        
                    }
                    .stroke(Color(editingProfile.selectedColor), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
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
            ToolbarItem (placement: .navigation)  {
               Image(systemName: "arrow.backward.circle")
               .foregroundColor(.white)
               .onTapGesture {
                   self.presentation.wrappedValue.dismiss()
               }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(profileManager.mode == .add ? "Novo Perfil" : "Editar Perfil")
        .background()
        .ignoresSafeArea()
    }

}

