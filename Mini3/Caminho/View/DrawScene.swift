//
//  PathDrawScene.swift
//  Mini3
//
//  Created by Pablo Penas on 08/12/21.
//

import Foundation
import SpriteKit

final class DrawScene: SKScene {
    
    var coordinates: [CGPoint] = []
    
    let startPosition = CGPoint(x: 100, y: 600)
    let finishPosition = CGPoint(x: 1000, y: 100)

    let initialBox = SKSpriteNode(color: SKColor.red, size: CGSize(width: 50, height: 50))
    let finishBox = SKSpriteNode(color: SKColor.blue, size: CGSize(width: 80, height: 50))
    
    override func didMove(to view: SKView) {
        initialBox.position = startPosition
        finishBox.position = finishPosition
        addChild(initialBox)
        addChild(finishBox)
    }
    
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
    
    func copyCoordinates() -> [CGPoint] {
        return coordinates
    }
         
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
