//
//  QuebraCabecaImageView.swift
//  Mini3
//
//  Created by Marco Zulian on 05/11/21.
//

import SwiftUI

struct QuebraCabecaImagePickerView: View {
    @EnvironmentObject private var selectedProfileManager: SelectedProfileManager
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var showingAlert = false
    @State private var inputImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @ObservedObject var cfg: PuzzleConfiguration
    
    var body: some View {
        ZStack {
            QuebraCabecaPreview(settings: cfg)

            Button {
                self.showingAlert.toggle()
            } label: {
                Image(systemName: "camera")
                    .foregroundColor(.white)
                    .font(.system(size: cameraIconFontSize, weight: .bold, design: .default))
                    .padding(25)
                    .background {
                        Circle()
                            .foregroundColor(selectedProfileManager.getProfileColor())
                    }
            }
            .offset(x: cameraIconXOffset, y: cameraIconYOffset)
            //TODO: Rever mensagem do alerta
            .alert("Selecionar Imagem", isPresented: $showingAlert) {
                Button("Tirar Foto") {
                    self.sourceType = .camera
                    self.showingImagePicker.toggle()
                }
                Button("Escolher Foto") {
                    self.sourceType = .photoLibrary
                    self.showingImagePicker.toggle()
                }
                Button("Cancelar", role: .cancel) {}
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage, sourceType: self.sourceType)
        }
        .navigationBarHidden(true)
    }
    
    func loadImage() {
        print("chamou")
        guard let inputImage = inputImage else {
            print("gl falhou")
            return
        }
        
        cfg.setImage(inputImage.resizeImageTo(size: CGSize(width: 362, height: 476))!)
        image = Image(uiImage: inputImage.resizeImageTo(size: CGSize(width: 362, height: 476))!)
    }
    
    //MARK: Constantes
    //TODO: Conferir tamanho do ícone da câmera
    //TODO: Conferir offset do ícone da câmera (tentar deixar dinâmico)
    //TODO: Conferir aspect ratio e frame da imagem
    let imageAspectRatio: CGFloat = 3/4
    let imageFrameWidth: CGFloat = 362
    let imageFrameHeight: CGFloat = 476
    let cameraIconFontSize: CGFloat = 30
    let cameraIconXOffset: CGFloat = 180
    let cameraIconYOffset: CGFloat = 230
}

struct QuebraCabecaImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        QuebraCabecaImagePickerView(cfg: PuzzleConfiguration())
            .environmentObject(SelectedProfileManager())
            .previewInterfaceOrientation(.landscapeRight)
    }
}
