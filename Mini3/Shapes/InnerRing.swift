//
//  InnerRing.swift
//  Mini3
//
//  Created by Pablo Penas on 11/11/21.
//

import SwiftUI

struct InnerRing : Shape {
    var lagAmmount = 0.35
    var pct: Double

    func path(in rect: CGRect) -> Path {

        let end = pct * 360
        var start: Double

        if pct > (1 - lagAmmount) {
            start = 360 * (2 * pct - 1.0)
        } else if pct > lagAmmount {
            start = 360 * (pct - lagAmmount)
        } else {
            start = 0
        }
        start = 0
        var p = Path()

        p.addArc(center: CGPoint(x: rect.size.width/2, y: rect.size.width/2),
                 radius: rect.size.width/2,
                 startAngle: Angle(degrees: start),
                 endAngle: Angle(degrees: end),
                 clockwise: false)

        return p
    }

    var animatableData: Double {
        get { return pct }
        set { pct = newValue }
    }
}
