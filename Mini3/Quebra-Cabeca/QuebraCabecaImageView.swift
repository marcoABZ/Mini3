//
//  QuebraCabecaImageView.swift
//  Mini3
//
//  Created by Marco Zulian on 05/11/21.
//

import SwiftUI

struct QuebraCabecaImageView: View {
    @EnvironmentObject private var student: Profile
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var showingAlert = false
    @State private var inputImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    private var color: Color
    @State private var cfg: MemoryGameConfiguration
    private var slices: [UIImage] {
        if let inputImage = inputImage {
            return inputImage.resizeImageTo(size: CGSize(width: 362, height: 476))!.slice(verticalPieces: student.vd, horizontalPieces: student.hd)
        }
        else {
            return []
        }
    }
    init(color: Color) {
        self.color = color
        cfg = MemoryGameConfiguration(verticalDivision: 1, horizontalDivision: 2, som: true, animacao: true, ordenacao: false, tipoOrdenacao: 0)
    }
    
    var body: some View {
        let im: Image? = image ?? Image("placeholder")
        
        ZStack {
            if !slices.isEmpty {
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 35), count: student.hd)) {
                // TODO: Setar ordenação com letras
                ForEach(0..<slices.count, id: \.self) { i in
                    PuzzlePiece(color: student.color, image: Image(uiImage: slices[i]), index: i + 1, ordered: student.or, targetPos: CGRect())

                }
            }
            .frame(width: imageFrameWidth, height: imageFrameHeight)
                
            } else {
                
            im?
                .resizable()
                .aspectRatio(imageAspectRatio, contentMode: .fit)
                .frame(width: imageFrameWidth, height: imageFrameHeight)
                
            }
//
            Button {
                self.showingAlert.toggle()
            } label: {
                Image(systemName: "camera")
                    .foregroundColor(.white)
                    .font(.system(size: cameraIconFontSize, weight: .bold, design: .default))
                    .padding()
                    .background {
                        Circle()
                            .foregroundColor(color)
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
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage, sourceType: self.sourceType)
        }
        .navigationBarHidden(true)
        .onAppear {
            loadCfg()
        }
        
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        
        image = Image(uiImage: inputImage.resizeImageTo(size: CGSize(width: 362, height: 476))!)
        student.image = inputImage.resizeImageTo(size: CGSize(width: 362, height: 476))!
        if var cfg = student.configs[.quebraCabeca] as? MemoryGameConfiguration {
            print("in")
            cfg.setImage(inputImage)
        }
    }
    
    func loadCfg() {
        if let cfg = student.configs[.quebraCabeca] as? MemoryGameConfiguration {
            self.cfg = cfg
        } else {
            student.configs[.quebraCabeca] = cfg
        }
    }
    
    //MARK: Constantes
    //TODO: Conferir tamanho do ícone da câmera
    //TODO: Conferir offset do ícone da câmera (tentar deixar dinâmico)
    //TODO: Conferir aspect ratio e frame da imagem
    let imageAspectRatio: CGFloat = 3/4
    let imageFrameWidth: CGFloat = 362
    let imageFrameHeight: CGFloat = 476
    let cameraIconFontSize: CGFloat = 24
    let cameraIconXOffset: CGFloat = 168
    let cameraIconYOffset: CGFloat = 226
}

struct QuebraCabecaImageView_Previews: PreviewProvider {
    static var previews: some View {
        QuebraCabecaImageView(color: .purple)
.previewInterfaceOrientation(.landscapeRight)
    }
}
