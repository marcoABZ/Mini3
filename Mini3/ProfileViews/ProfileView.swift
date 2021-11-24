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
                        dashboardManager.getGamesAvailable(mascote: profileManager.selectedProfile?.mascote ?? .coelho)
                        dashboardManager.hasSidebar = true
                        self.presentation.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(profileManager.addingProfile ? "Novo Perfil" : "Editar Perfil")
            .onAppear() {
                profileManager.getProfile()
                dashboardManager.hasSidebar = false
            }
            .ignoresSafeArea()
            //TODO: Criar um manager para as imagens
            //Apagar
//            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
//                ImagePicker(image: self.$inputImage, sourceType: self.sourceType)
//            }
    }
        
//        ZStack {
//            profileManager.editingProfile.selectedColor.opacity(0.5).ignoresSafeArea()
//
//            VStack {
//                ZStack {
//                    HStack {
//                        Button(action: {
//                            profileManager.dismissProfileView()
//                        }) {
//                            Image(systemName: "arrow.left.circle")
//                                .font(.system(size: 28).bold())
//                            Text("voltar")
//                                .padding(.horizontal)
//                                .font(.system(size: 24).bold())
//                        }
//                        .foregroundColor(profileManager.editingProfile.selectedColor)
//                        .frame(width: 200, height: 55)
//                        .background(.white)
//                        .cornerRadius(30)
//                        Spacer()
//                    }
//                    .padding(.horizontal,105)
//                    Text("Novo Perfil")
//                        .foregroundColor(profileManager.editingProfile.selectedColor)
//                        .font(.system(size: 24).bold())
//                }
//                .padding(.vertical,16)
//
//                HStack {
//                    VStack {
//                        Text("Foto de perfil")
//                            .foregroundColor(.gray)
//                            .font(.system(size: 24).bold())
//                            .padding(.top, 56)
//
//                        Button(action: {
//                            //Apagar
//                            self.showingAlert.toggle()
//
//                        }) {
//                            ZStack {
//                                im
//                                    .font(.system(size: 70))
//                                    .foregroundColor(.gray)
//                                    .frame(width: 210, height: 210)
//                                    .background(.gray.opacity(0.5))
//                                    .cornerRadius(12)
//
//                                VStack {
//                                    HStack {
//                                        Image(systemName: "camera")
//                                            .font(.system(size: 32, weight: .bold))
//                                            .foregroundColor(.white)
//                                        .frame(width: 64, height: 64)
//                                        .background(profileManager.editingProfile.selectedColor)
//                                        .cornerRadius(32)
//                                        .offset(x: 105, y: 105)
//                                    }
//                                }
//                            }
//                        }
//                        //Apagar
//                        .alert("Selecionar Imagem", isPresented: $showingAlert) {
//                            Button("Tirar Foto") {
//                                self.sourceType = .camera
//                                self.showingImagePicker.toggle()
//                            }
//                            Button("Escolher Foto") {
//                                self.sourceType = .photoLibrary
//                                self.showingImagePicker.toggle()
//                            }
//                        }
//
//                        Text("Cor de fundo")
//                            .font(.system(size: 24).bold())
//                            .foregroundColor(.gray)
//                            .padding(.top,24)
//                            .padding(.bottom, 42)
//
//                        HStack(spacing: 24) {
//                            Button(action: {
//                                profileManager.editingProfile.selectedColor = profileManager.neutralColor
//                            }) {
//                                Rectangle()
//                                    .fill(.clear)
//                                    .frame(width: 64, height: 64)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 16)
//                                            .stroke(Color.gray, lineWidth: 3)
//                                            .overlay(
//                                                Path { path in
//                                                    path.move(to: CGPoint(x: 48, y: 16))
//                                                    path.addLine(to: CGPoint(x: 16, y: 48))
//                                                }
//                                                    .stroke(Color.gray, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
//                                            )
//                                    )
//                            }
//                            VStack(spacing: 24) {
//                                HStack(spacing: 24) {
//                                    ForEach(0..<profileManager.availableColors.count/2) { i in
//                                        Button(action: {
//                                            profileManager.editingProfile.selectedColor = profileManager.availableColors[i]
//                                        }) {
//                                            Rectangle()
//                                                .fill(profileManager.availableColors[i])
//                                                .frame(width: 64, height: 64)
//                                                .cornerRadius(16)
//                                        }
//                                    }
//                                }
//                                HStack(spacing: 24) {
//                                    ForEach(0..<profileManager.availableColors.count/2) { i in
//                                        Button(action: {
//                                            profileManager.editingProfile.selectedColor = profileManager.availableColors[i+3]
//                                        }) {
//                                            Rectangle()
//                                                .fill(profileManager.availableColors[i + profileManager.availableColors.count/2])
//                                                .frame(width: 64, height: 64)
//                                                .cornerRadius(16)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                        .padding(.bottom, 56)
//                    }
//                    .frame(maxWidth: 492)
//
//                    VStack {
//                        Spacer()
//                        Path { path in
//                            path.move(to: CGPoint(x: 0, y: 0))
//                            path.addLine(to: CGPoint(x: 0, y: 560))
//
//                        }
//                        .stroke(Color.gray, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
//                        .frame(width: 3, height: 560)
//                        Spacer()
//                    }
//
//                    VStack {
//                        VStack(alignment: .leading) {
//                            Text("Nome")
//                                .font(.system(size: 24, design: .rounded).bold())
//
//                            TextField("Nome", text: $profileManager.editingProfile.name)
//                                .padding(.leading)
//                                .padding(12)
//                                .background(.gray.opacity(0.2))
//                                .cornerRadius(30)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 30)
//                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
//                                )
//
//                            DatePicker("Data de Nascimento", selection: $profileManager.editingProfile.birthdate, in: ...Date(), displayedComponents: .date)
//                                .font(.system(size: 24, design: .rounded).bold())
//                                .padding(.top, 24)
//
//                            Text("Escolher Mascote")
//                                .font(.system(size: 24, design: .rounded).bold())
//                                .padding(.top, 24)
//
//                            HStack(spacing: 35) {
//                                Spacer()
//                                ForEach(0..<Mascotes.allCases.count) { i in
//                                    Button(action: {
//                                        profileManager.editingProfile.mascote = Mascotes.allCases[i]
//                                    }) {
//                                        Image(Mascotes.getImageIconName(animal: Mascotes.allCases[i]))
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                            .frame(width: 94, height: 94)
//                                            .foregroundColor(.gray.opacity(0.2))
//                                            .cornerRadius(16)
//                                            .overlay(
//                                                RoundedRectangle(cornerRadius: 19)
//                                                    .stroke(profileManager.editingProfile.selectedColor, lineWidth: profileManager.editingProfile.mascote == Mascotes.allCases[i] ? 8 : 0)
//                                                    .frame(width: 100, height: 100)
//                                            )
//                                    }
//                                }
//                            }
//
//                            Toggle("Modo escuro", isOn: $profileManager.editingProfile.darkModeEnabled)
//                                .font(.system(size: 24, design: .rounded).bold())
//                                .padding(.top, 24)
//
//                        }
//                        .foregroundColor(.gray)
//
//
//                        Button(action: {
//                            profileManager.saveProfile(image: im!)
//                            dashboardManager.getGamesAvailable(mascote: profileManager.selectedProfile!.mascote)
//                        }) {
//                            Text(profileManager.addingProfile ? "Criar" : "Salvar")
//                                .font(.system(size: 24).bold())
//                                .foregroundColor(.white)
//                        }
//                        .frame(width: 240, height: 55)
//                        .background(.gray.opacity(0.4))
//                        .cornerRadius(30)
//                        .padding(.top,42)
//                    }
//                    .padding(.trailing, 80)
//                    .padding(.leading, 36)
//                    .frame(maxWidth: 492)
//                }
//                .background(.white)
//                .cornerRadius(32)
//            }
//            .frame(maxHeight: 640)
//        }
//        .onAppear() {
//            profileManager.getProfile()
//        }
//        .ignoresSafeArea()
//        //TODO: Criar um manager para as imagens
//        //Apagar
//        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
//            ImagePicker(image: self.$inputImage, sourceType: self.sourceType)
//        }
//    }
//    
//    func loadImage() {
//        guard let inputImage = inputImage else {
//            return
//        }
//        
//        image = Image(uiImage: inputImage)
//    }
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(ProfileManager())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
