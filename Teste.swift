//
//  ConfigurationView.swift
//  Mini3
//
//  Created by Marco Zulian on 10/11/21.
//

import SwiftUI

class ItemConfiguration<Tipo> {
    var title: String
    var subtitle: String?
    var selector: SelectorType
    var variable: Binding<Tipo>
    
    init(title: String, subtitle: String?, selector: SelectorType, variable: Binding<Tipo>) {
        self.title = title
        self.subtitle = subtitle
        self.selector = selector
        self.variable = variable
    }
}

protocol Configuration_ {
    var title: String { get }
    var description: String? { get }
    
}

class BaseConfiguration<T>: Configuration_, ObservableObject {
    var title: String
    var description: String?
    
    var selector: SelectorType
    @Published var value: T
    
    init(title: String, description: String?, selector: SelectorType, value: T) {
        self.title = title
        self.description = description
        self.selector = selector
        self.value = value
    }
}

struct CompositeConfiguration: Configuration_ {
    var title: String
    var description: String?
    
    var option: [Configuration_]
}
