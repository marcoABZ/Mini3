//
//  ImageExtension.swift
//  Mini3
//
//  Created by Marco Zulian on 08/11/21.
//

import SwiftUI

extension Image {
    func slice(image: UIImage, into howMany: Int) -> [UIImage] {
        let width: CGFloat
        let height: CGFloat

        switch image.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            width = image.size.height
            height = image.size.width
        default:
            width = image.size.width
            height = image.size.height
        }

        let tileWidth = Int(width / CGFloat(howMany))
        let tileHeight = Int(height / CGFloat(howMany))

        let scale = Int(image.scale)
        var images = [UIImage]()

        let cgImage = image.cgImage!

        var adjustedHeight = tileHeight

        var y = 0
        for row in 0 ..< howMany {
            if row == (howMany - 1) {
                adjustedHeight = Int(height) - y
            }
            var adjustedWidth = tileWidth
            var x = 0
            for column in 0 ..< howMany {
                if column == (howMany - 1) {
                    adjustedWidth = Int(width) - x
                }
                let origin = CGPoint(x: x * scale, y: y * scale)
                let size = CGSize(width: adjustedWidth * scale, height: adjustedHeight * scale)
                let tileCgImage = cgImage.cropping(to: CGRect(origin: origin, size: size))!
                images.append(UIImage(cgImage: tileCgImage, scale: image.scale, orientation: image.imageOrientation))
                x += tileWidth
            }
            y += tileHeight
        }
        return images
    }
}
