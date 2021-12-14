//
//  NavAppearenceModifier.swift
//  Mini3
//
//  Created by Marco Zulian on 17/11/21.
//

import SwiftUI

struct NavAppearanceModifier: ViewModifier {
    init(foregroundColor: UIColor, tintColor: UIColor?, hideSeparator: Bool) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: foregroundColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor]
//        navBarAppearance.titleTextAttributes = [.foregroundColor: foregroundColor, .font: UIFont.systemFont(ofSize: 24, weight: .bold)]
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor, .font: UIFont.systemFont(ofSize: 24, weight: .bold)]
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.setBackIndicatorImage(UIImage(systemName: "arrow.backward.circle"), transitionMaskImage: UIImage(systemName: "arrow.backward.circle"))
        if hideSeparator {
            navBarAppearance.shadowColor = .clear
        }

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        if let tintColor = tintColor {
            UINavigationBar.appearance().tintColor = tintColor
        }
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func navigationAppearance(foregroundColor: UIColor, tintColor: UIColor? = nil, hideSeparator: Bool = false) -> some View {
        self.modifier(NavAppearanceModifier(foregroundColor: foregroundColor, tintColor: tintColor, hideSeparator: hideSeparator))
    }
}
