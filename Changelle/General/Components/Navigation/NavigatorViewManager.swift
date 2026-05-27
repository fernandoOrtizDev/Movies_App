//
//  NavigatorViewManager.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 22/07/25.
//

import Foundation

import SwiftUI

struct NavigatorScreen: Identifiable, Hashable {
    let id = UUID()
    let view: AnyView
    let typeName: String
    
    init<Pepito: View>(view: Pepito) {
        self.view = AnyView(view)
        self.typeName = String (describing: Pepito.self)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool { lhs.id == rhs.id }
    
    func hash(into h: inout Hasher) { h.combine(self.id) }
}
