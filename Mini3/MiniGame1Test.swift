//
//  MiniGame1Test.swift
//  Mini3
//
//  Created by Pablo Penas on 05/11/21.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene {
    var rectangleBox = SKSpriteNode()
    var targetBox = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.rectangleBox = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
        rectangleBox.position = CGPoint(x: 50, y: 50)
        
        
        self.targetBox = SKSpriteNode(color: .white, size: CGSize(width: 50, height: 50))
        targetBox.position = CGPoint(x: 200, y: 350)
        
        
        self.addChild(targetBox)
        self.addChild(rectangleBox)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let xDis = targetBox.position.x - rectangleBox.position.x
        let yDis = targetBox.position.y - rectangleBox.position.y
        
        let euclideanDis = pow(pow(xDis, 2) + pow(yDis, 2), 0.5)
        
        if euclideanDis <= 20 {
            rectangleBox.position = targetBox.position
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }
        self.rectangleBox.position = firstTouch.location(in: self)
    }
}

struct MiniGame1Test: View {
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 300, height: 400)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        VStack {
            Text("Isso ta em SwiftUI")
            SpriteView(scene: scene)
                .frame(width: 300, height: 400)
        }
    }
}

struct MiniGame1Test_Previews: PreviewProvider {
    static var previews: some View {
        MiniGame1Test()
    }
}
