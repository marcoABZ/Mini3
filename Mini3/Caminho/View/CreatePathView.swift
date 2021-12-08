//
//  CreatePathView.swift
//  Mini3
//
//  Created by Pablo Penas on 08/12/21.
//

import SwiftUI
import SpriteKit


final class DrawScene: SKScene {
    var coordinates: [CGPoint] = []
    
    let startPosition = CGPoint(x: 100, y: 600)
    let finishPosition = CGPoint(x: 1000, y: 100)

    let initialBox = SKSpriteNode(color: SKColor.red, size: CGSize(width: 50, height: 50))
    let finishBox = SKSpriteNode(color: SKColor.blue, size: CGSize(width: 80, height: 50))
    
    
    
    func pointToAdd(addingPosition: CGPoint) -> Bool {
        if coordinates.isEmpty {
            if !initialBox.contains(addingPosition) {
                return false
            }
            coordinates.append(addingPosition)
            return true
        } else {
            let lastAddedCoordinate = coordinates.last!
            let xDis = Float(addingPosition.x) - Float(lastAddedCoordinate.x)
            let yDis = Float(addingPosition.y) - Float(lastAddedCoordinate.y)
            let distance = sqrt(pow(xDis, 2) + pow(yDis, 2))
            print("added")
            if distance >= 20 && distance <= 40 {
                print("added")
                self.coordinates.append(addingPosition)
                if finishBox.contains(addingPosition) {
                    print(coordinates)
                }
                return true
            } else {
                return false
            }
        }
    }
    
//    func copyCoordinates() {
//        pathManager.coordinates = self.coordinates
//    }
         
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if pointToAdd(addingPosition: location) {
            let mark = SKShapeNode(circleOfRadius: 5.0)
            mark.position = location
            addChild(mark)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if pointToAdd(addingPosition: location) {
            let mark = SKShapeNode(circleOfRadius: 5.0)
            mark.position = location
            addChild(mark)
        }
    }
}

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
    var scene: DrawScene {
        let scene = DrawScene()
        scene.size = CGSize(width: 1200, height: 700)
        scene.scaleMode = .fill
        
        scene.initialBox.position = scene.startPosition
        scene.finishBox.position = scene.finishPosition
        scene.addChild(scene.initialBox)
        scene.addChild(scene.finishBox)
        
        return scene
    }
    var body: some View {
        VStack {
            if pathManager.switchView {
                SpriteView(scene: scene)
                    .frame(width: 1200, height: 700)
                    .ignoresSafeArea()
            } else {
                PathView(coordinates: pathManager.convertToCGPoint())
            }
            Button(action: {
//                pathManager.coordinates = scene.copyCoordinates()
//                print(pathManager.coordinates)
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
