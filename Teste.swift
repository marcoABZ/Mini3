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

struct BaseConfiguration<T>: Configuration_ {
    var title: String
    var description: String?
    
    var selector: SelectorType
    var value: T
}

struct CompositeConfiguration: Configuration_ {
    var title: String
    var description: String?
    
    var option: [Configuration_]
}

//struct Puzzle {
//    var configurations: [Configuration_] = [
//        CompositeConfiguration(
//            title: "Quantidade de divisões",
//            description: "Quantidade de pedaços que a imagem será divididada.",
//            option: [BaseConfiguration<Int>(title: "Divisoes horizontais", selector: .plusMinus, value: 2),
//                 BaseConfiguration<Int>(title: "Divisoes verticais", selector: .plusMinus, value: 2)]),
//        BaseConfiguration<Bool>(
//            title: "Efeitos sonoros",
//            description: "Sons de efeito realizados durante  a interação demonstrando simples.",
//            selector: .toggle,
//            value: true),
//        BaseConfiguration<Bool>(
//            title: "Animações",
//            selector: .toggle,
//            value: true),
//        BaseConfiguration<Int>(
//            title: "Incluir ordenação",
//            selector: .wheel,
//            value: 0)]
//}

//class PuzzleManager: ObservableObject {
//    @Published var model: Puzzle = Puzzle()
//}

//struct PuzzleConfigurationView: View {
//    @ObservedObject var viewModel: PuzzleManager
//
//    var body: some View {
//        ForEach(viewModel.model.configurations, id: \.self.title) { cfg in
//
//        }
//    }
//}
