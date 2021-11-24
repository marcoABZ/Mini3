//
//  LeftPannelView.swift
//  Mini3
//
//  Created by Marco Zulian on 23/11/21.
//

import SwiftUI

struct LeftPannelView: View {
    @EnvironmentObject var profileManager: ProfileManager
    @EnvironmentObject var dashboardManager: DashboardManager
    
    //Apagar
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var showingAlert = false
    @State private var inputImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        let im: Image? = image ?? profileManager.editingProfile.image
        
        VStack {
            Text("Foto de perfil")
                .padding(.top, 56)
            
            Button(action: {
                //Apagar
                self.showingAlert.toggle()
                
            }) {
                ZStack {
                    im
                        .font(.system(size: 70))
                        .foregroundColor(.gray)
                        .frame(width: 210, height: 210)
                        .background(.gray.opacity(0.5))
                        .cornerRadius(12)
                    
                    VStack {
                        HStack {
                            Image(systemName: "camera")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                            .frame(width: 64, height: 64)
                            .background(profileManager.editingProfile.selectedColor)
                            .cornerRadius(32)
                            .offset(x: 105, y: 105)
                        }
                    }
                }
            }
            //Apagar
            .alert("Selecionar Imagem", isPresented: $showingAlert) {
                Button("Tirar Foto") {
                    self.sourceType = .camera
                    self.showingImagePicker.toggle()
                }
                Button("Escolher Foto") {
                    self.sourceType = .photoLibrary
                    self.showingImagePicker.toggle()
                }
            }
            
            Text("Cor de fundo")
                .padding(.top,42)
                .padding(.bottom, 24)
            
            BackgroundColorPickerView()
        }
        .frame(maxWidth: 492)
        .font(.system(size: 24, weight: .bold, design: .rounded))
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage, sourceType: self.sourceType)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        
        image = Image(uiImage: inputImage.resizeImageTo(size: CGSize(width: 165, height: 165)) ?? inputImage)
        profileManager.editingProfile.image = image!
    }
}

