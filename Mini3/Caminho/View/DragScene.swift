//
//  DragScene.swift
//  Mini3
//
//  Created by Pablo Penas on 09/12/21.
//

import Foundation
import SpriteKit

final class DragScene: SKScene {
    
    var coordinates: [CGPoint] = []
    var coloredCoordinates: [CGPoint] = []
    
    let path = UIBezierPath()
//    let maskLayer = CAShapeLayer()
    
    let rocketImage = UIImage(named: "rocket")
    let planetImage = UIImage(named: "planetDestiny")
    
    var pathNode: SKShapeNode!
    var coloredPathNode: SKShapeNode!
    var planetNode: SKSpriteNode!
    
    var rocket: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        rocket = SKSpriteNode(texture: SKTexture(image: rocketImage!))
        path.move(to: coordinates.first ?? .zero)
        for coordinate in coordinates {
            path.addLine(to: coordinate)
        }
        rocket.position = coordinates.first ?? .zero
        rocket.zPosition = 11
        
        pathNode = SKShapeNode(path: path.cgPath)
        
//        maskLayer.path = path.cgPath
//        maskLayer.lineCap = .round
//        maskLayer.lineWidth = 50
//        maskLayer.fillColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
//        view.layer.addSublayer(maskLayer)
        
        coloredPathNode = SKShapeNode()
        coloredPathNode.strokeColor = UIColor.red
        coloredPathNode.lineWidth = 30

        pathNode.strokeColor = UIColor.white
        pathNode.lineWidth = 60
        pathNode.zPosition = 6
        
        planetNode = SKSpriteNode(texture: SKTexture(image: planetImage!))
        planetNode.position = CGPoint(x: 890, y: 70)
        planetNode.zPosition = 10
        
        addChild(planetNode)
        addChild(pathNode)
        addChild(coloredPathNode)
        addChild(rocket)
        
        let background = SKSpriteNode(imageNamed: "caminhoBackground")
        background.size = view.frame.size
        background.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        background.zPosition = 0
        addChild(background)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        if rocket.contains(touchLocation) {
            rocket.position = touchLocation
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if rocket.contains(touchLocation) && pathNode.contains(touchLocation) {
//            rocket.position = touchLocation
            handleColoring(location: touchLocation)
        }
    }
    
    func handleColoring(location: CGPoint) {
        var stopIndex = 0
        for coordinate in coordinates {
            let xDis = Float(coordinate.x) - Float(location.x)
            let yDis = Float(coordinate.y) - Float(location.y)
            let distance = sqrt(pow(xDis, 2) + pow(yDis, 2))
            if distance <= 40 {
                stopIndex = coordinates.firstIndex(of: coordinate)!
            }
        }
        for index in 0...stopIndex {
            if !coloredCoordinates.contains(coordinates[index]) {
                coloredCoordinates.append(coordinates[index])
            }
        }
        let coloredPath = UIBezierPath()
        coloredPath.move(to: coloredCoordinates.first ?? .zero)
        for coordinate in coloredCoordinates {
            coloredPath.addLine(to: coordinate)
        }
        coloredPathNode = SKShapeNode(path: coloredPath.cgPath)
        coloredPathNode.strokeColor = UIColor.red
        coloredPathNode.lineWidth = 30
        coloredPathNode.zPosition = 9
        rocket.position = coloredCoordinates.last ?? location
        addChild(coloredPathNode)
    }
}
