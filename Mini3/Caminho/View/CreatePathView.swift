//
//  CreatePathView.swift
//  Mini3
//
//  Created by Pablo Penas on 08/12/21.
//

import SwiftUI
import SpriteKit

struct CreatePathView: View {
    @StateObject var pathManager: PathManager = PathManager()

    var body: some View {
        VStack {
            if pathManager.switchView {
                SpriteView(scene: pathManager.scene)
                    .frame(width: 1000, height: 700)
                    .ignoresSafeArea()
            } else {
                SpriteView(scene: pathManager.scene)
                    .frame(width: 1000, height: 700)
                    .ignoresSafeArea()
//                PathView(coordinates: pathManager.coordinates)
            }
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
            Spacer()
        }
    }
    
}

struct CreatePathView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePathView()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(PathManager())
    }
}
