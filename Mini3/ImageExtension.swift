//
//  ImageExtension.swift
//  Mini3
//
//  Created by Marco Zulian on 08/11/21.
//

import SwiftUI

extension UIImage {
    func slice(verticalPieces vertical: Int, horizontalPieces horizontal: Int) -> [UIImage] {
        let width: CGFloat
        let height: CGFloat

        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            width = self.size.height
            height = self.size.width
        default:
            width = self.size.width
            height = self.size.height
        }

        let tileWidth = Int(width / CGFloat(horizontal))
        let tileHeight = Int(height / CGFloat(vertical))

        let scale = Int(self.scale)
        var images = [UIImage]()

        let cgImage = self.cgImage!

        var adjustedHeight = tileHeight

        var y = 0
        for row in 0 ..< vertical {
            if row == (vertical - 1) {
                adjustedHeight = Int(height) - y
            }
            var adjustedWidth = tileWidth
            var x = 0
            for column in 0 ..< horizontal {
                if column == (horizontal - 1) {
                    adjustedWidth = Int(width) - x
                }
                let origin = CGPoint(x: x * scale, y: y * scale)
                let size = CGSize(width: adjustedWidth * scale, height: adjustedHeight * scale)
                let tileCgImage = cgImage.cropping(to: CGRect(origin: origin, size: size))!
                images.append(UIImage(cgImage: tileCgImage, scale: self.scale, orientation: self.imageOrientation))
                x += tileWidth
            }
            y += tileHeight
        }
        return images
    }
}
