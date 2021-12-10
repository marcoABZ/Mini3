//
//  CaminhoGameView.swift
//  Mini3
//
//  Created by Pablo Penas on 10/12/21.
//

import SwiftUI
import SpriteKit

struct ProgressBarView: View {
    @Binding var progress: Float
    var body: some View {
        Rectangle()
            .fill(.white)
            .frame(width: 550, height: 50)
            .cornerRadius(25)
            .overlay(
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: getGradientColor()), startPoint: .trailing, endPoint: .leading)
                         )
                    .frame(width: 50 + CGFloat(progress), height: 50)
                    .cornerRadius(25),
                alignment: .leading
            )
    }
    
    func getGradientColor() -> [Color] {
        let blue = Color(red: 52/255, green: 100/255, blue: 172/255, opacity: 1)
        let purple = Color(red: 166/255, green: 144/255, blue: 215/255)
        let orange = Color(red: 1, green: 142/255, blue: 142/255)
        let yellow = Color(red: 233/255, green: 193/255, blue: 116/255)
        if progress == 0 {
            return [blue]
        } else if progress <= 100 {
            let r = blue.cgColor!.components![0] + Double(progress/100) * (purple.cgColor!.components![0]-(blue.cgColor?.components![0])!)
            let g = blue.cgColor!.components![1] + Double(progress/100) * (purple.cgColor!.components![1]-(blue.cgColor?.components![1])!)
            let b = blue.cgColor!.components![2] + Double(progress/100) * (purple.cgColor!.components![2]-(blue.cgColor?.components![2])!)
            
            let inter = Color(red: r, green: g, blue: b)
            return [blue,inter]
        } else if progress <= 300 {
            let r = purple.cgColor!.components![0] + Double(progress - 100)/200 * (orange.cgColor!.components![0]-(purple.cgColor?.components![0])!)
            let g = purple.cgColor!.components![1] + Double(progress-100)/200 * (orange.cgColor!.components![1]-(purple.cgColor?.components![1])!)
            let b = purple.cgColor!.components![2] + Double(progress-100)/200 * (orange.cgColor!.components![2]-(purple.cgColor?.components![2])!)
            
            let inter = Color(red: r, green: g, blue: b)
            return [blue,purple,inter]
        } else {
            let r = orange.cgColor!.components![0] + Double(progress - 100)/200 * (yellow.cgColor!.components![0]-(orange.cgColor?.components![0])!)
            let g = orange.cgColor!.components![1] + Double(progress-100)/200 * (yellow.cgColor!.components![1]-(orange.cgColor?.components![1])!)
            let b = orange.cgColor!.components![2] + Double(progress-100)/200 * (yellow.cgColor!.components![2]-(orange.cgColor?.components![2])!)
            
            let inter = Color(red: r, green: g, blue: b)
            return [blue,purple,orange,inter]
        }
    }
}

struct CaminhoGameView: View {
    @StateObject var pathManager: PathManager = PathManager()
    @EnvironmentObject var selectedProfileManager: SelectedProfileManager
    
    var body: some View {
        ZStack {
            selectedProfileManager.getProfileColor()
                .ignoresSafeArea(.all)
            ZStack(alignment: .top) {
                
                if pathManager.switchView {
                    SpriteView(scene: pathManager.scene)
                        .frame(width: 986, height: 662)
                        .cornerRadius(30)
                } else {
                    SpriteView(scene: pathManager.scene)
                        .frame(width: 986, height: 662)
                        .cornerRadius(30)
    //                PathView(coordinates: pathManager.coordinates)
                }
                
//                SpriteView(scene: pathManager.scene)
//                    .frame(width: 986, height: 662)
//                    .cornerRadius(30)
                ProgressBarView(progress: $pathManager.progress)
                    .offset(y: -25)
                VStack {
                    Spacer()
                    Button(action: {
                        pathManager.copyCoordinates()
                        pathManager.switchToDragScene()
                        pathManager.switchView.toggle()
                    }) {
                        Text("Gerar Caminho")
                            .font(.title)
                    }
                    .padding()
                    .background(.gray)
                    .cornerRadius(20)
                }
            }
            .padding(.top)
        }
        .toolbar {
            
        }
    }
}

struct CaminhoGameView_Previews: PreviewProvider {
    static var previews: some View {
        CaminhoGameView()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(SelectedProfileManager(profile: ProfileModel(name: "", birthdate: Date(), color: .orange, image: "")))
    }
}
