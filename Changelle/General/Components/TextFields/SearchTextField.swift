//
//  SearchTextField.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 21/07/25.
//

import SwiftUI

struct SearchTextField: View {
    
    @Binding var text: String
    private var placeholder: String = ""
    
    var body: some View {
        ErrorTextField(text: $text, validations: [])
            .placeholder(self.placeholder)
            .leftView(AnyView(self.leftView))
            .backgroundColor(.neutral50)
            .autocorrectionDisabled()
            .foregroundColor(.neutral100)
    }
    
    init(text: Binding<String>) {
        _text = text
    }
    
    func placeholder(_ value: String) -> Self {
        var view = self
        view.placeholder = value
        return view
    }
    
    private var leftView: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.neutral300)
        }
    }
}
