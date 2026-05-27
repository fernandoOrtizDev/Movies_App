//
//  CarListFeedbackView.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 31/07/25.
//


import SwiftUI

struct CarListFeedbackView: View {
    
    private let messsage: String
    private let style: CarListFeedbackView.Style
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center, spacing: Spacing._xl) {
                Spacer()
                self.style.format.image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(self.style.format.color)
                TextLabel(text: self.messsage, aligment: .center)
                Spacer()
            }
            .padding(Spacing._xl)
            Spacer()
        }
    }
    
    init(messsage: String, style: CarListFeedbackView.Style) {
        self.messsage = messsage
        self.style = style
    }
}

extension CarListFeedbackView {
    enum Style {
        case warning
        case error
        
        var format: (image: Image, color: Color) {
            switch self {
            case .warning:
                (Image(systemName: "exclamationmark.triangle"), .warning500)
            case .error:
                (Image(systemName: "exclamationmark.triangle"), .error500)
            }
        }
    }
}

#Preview {
    CarListFeedbackView(messsage: "Este es un mensaje de prueba", style: .error)
}
