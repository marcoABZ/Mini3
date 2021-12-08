//
//  PathManager.swift
//  Mini3
//
//  Created by Pablo Penas on 08/12/21.
//

import SwiftUI
import SpriteKit

class PathManager: ObservableObject {
    @Published var coordinates: [CGPoint] = []
    @Published var switchView = true
    
    var drawScene: DrawScene?
    var scene: SKScene
    
    init() {
        scene = DrawScene()
        scene.size = CGSize(width: 1200, height: 700)
        scene.scaleMode = .fill

        drawScene = scene as? DrawScene
    }
    
    let path = [(112.5, 587.5), (139.0, 587.5), (159.50003051757812, 587.5), (185.0, 584.0), (208.00003051757812, 575.5), (232.5, 565.5), (249.99996948242188, 554.5), (266.5, 541.5), (280.0000305175781, 523.5), (290.0, 506.0), (300.0, 484.5), (307.5, 465.5), (316.4999694824219, 437.0), (322.0, 417.0), (327.5, 396.0), (335.0, 376.5), (349.0, 348.0), (360.5, 329.0000305175781), (374.5, 314.0), (393.0, 304.0), (413.0, 299.0), (436.5, 297.5), (464.5, 297.5), (494.5, 304.0), (523.0, 312.0), (557.0, 321.0), (579.5, 326.5), (603.5000610351562, 330.5), (631.5, 332.5000305175781), (659.0, 329.5), (678.0, 319.5), (699.0, 302.0), (714.0, 280.0), (732.5, 252.0), (751.0, 237.50001525878906), (770.5, 220.5), (783.0, 197.50001525878906), (785.0, 177.50001525878906), (785.0, 155.99998474121094), (805.0, 151.5), (827.0, 152.49998474121094), (849.5, 155.50001525878906), (875.5, 154.00001525878906), (894.5, 147.5), (914.0, 142.0), (937.5, 134.49998474121094), (956.5, 126.99998474121094), (977.5, 118.5), (997.5, 111.0)]
    
    func convertToCGPoint() -> [CGPoint] {
        var pathConverted: [CGPoint] = []
        for coordinate in path {
            pathConverted.append(CGPoint(x: coordinate.0, y: coordinate.1))
        }
        return pathConverted
    }
    
    func copyCoordinates() {
//        coordinates = (drawScene?.copyCoordinates())!
    }
}
