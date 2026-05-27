//
//  TextBody.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 17/06/25.
//

import SwiftUI

struct TextCaption: View {
    var text: String
    var color: ColorType = .regular
    var type: Style = .regular
    var body: some View {
        Text(self.text)
            .font(self.type.font)
            .foregroundStyle(self.color.color)
            .lineLimit(nil)
            .lineSpacing(7)
    }

    enum Style {
        case regular
        case bold
        case bold1
        var font: Font {
            switch self {
            case .regular:
                return .system(size: 12)
            case .bold:
                return .system(size: 12, weight: .bold)
            case .bold1:
                return .system(size: 15)
            }
            
        }
    }

    enum ColorType {
        case regular
        case bold
        case text
        var color: Color {
            switch self {
            case .regular:
                return Color("TextPrimary")
            case .bold:
                return Color("CardBackground")
            case .text:
                return Color(.neutral400)
            }
        }
    }
}
