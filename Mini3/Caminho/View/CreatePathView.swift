//
//  CreatePathView.swift
//  Mini3
//
//  Created by Pablo Penas on 08/12/21.
//

import SwiftUI
import SpriteKit

struct PathView: View {
    let coordinates: [CGPoint]
    var body: some View {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: 100, y: 10))
            path.addLines(coordinates)
        }
        .stroke(Color.orange, lineWidth: 5)
    }
}

struct CreatePathView: View {
    @StateObject var pathManager: PathManager = PathManager()

    var body: some View {
        VStack {
            if pathManager.switchView {
                SpriteView(scene: pathManager.scene)
                    .frame(width: 1200, height: 700)
                    .ignoresSafeArea()
            } else {
                PathView(coordinates: pathManager.coordinates)
            }
            Button(action: {
                if pathManager.switchView {
                    pathManager.copyCoordinates()
                }
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
