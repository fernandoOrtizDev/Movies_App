//
//  TextLabel.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 17/06/25.
//

import SwiftUI

struct TextLabel: View {
    var text: String
    var color: Color = .neutral500
    var aligment: TextAlignment = .leading
    var body: some View {
        Text(self.text)
            .font(Fonts.label_md)
            .foregroundStyle(self.color)
            .lineLimit(nil)
            .lineSpacing(3)
            .multilineTextAlignment(self.aligment)
    }
}
