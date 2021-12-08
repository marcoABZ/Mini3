//
//  GameView.swift
//  Mini3
//
//  Created by Pablo Penas on 07/12/21.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene {
    let level1 = SKShapeNode(circleOfRadius: 30.0)
         
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}


struct GameView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 1200, height: 800)
        scene.scaleMode = .fill
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 400))
        path.addCurve(to: CGPoint(x: 500, y: 400), controlPoint1: CGPoint(x: 200, y: 700), controlPoint2: CGPoint(x: 300, y: 700))
        path.addCurve(to: CGPoint(x: 140, y: 0), controlPoint1: CGPoint(x: 60, y: 180), controlPoint2: CGPoint(x: 140, y: 10))
        path.addCurve(to: CGPoint(x: 280, y: 0), controlPoint1: CGPoint(x: 220, y: -180), controlPoint2: CGPoint(x: 280, y: 0))
        path.addCurve(to: CGPoint(x: 440, y: 0), controlPoint1: CGPoint(x: 400, y: -300), controlPoint2: CGPoint(x: 440, y: 0))
//        scene.level1.zPosition = 10
//        addChild(level1)

        let shapeNode = SKShapeNode(path: path.cgPath)
        shapeNode.strokeColor = UIColor.white
        scene.addChild(shapeNode)
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
                    .frame(width: 1200, height: 800)
                    .ignoresSafeArea()

    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
