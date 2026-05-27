//
//  NavigatorView.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 22/07/25.
//

import SwiftUI

struct NavigatorActionButton {
    let title: String
    let action: (() -> Void)?
}

struct NavigatorBarTitleAndAction: ViewModifier {
    private let trailingAction: NavigatorActionButton
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        NavigatorViewManager.shared.pop()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.neutral500)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.trailingAction.action?()
                    } label: {
                        Image(systemName: self.trailingAction.title)
                    }
                }
            }
    }
    
    init(trailingAction: NavigatorActionButton) {
        self.trailingAction = trailingAction
    }
}

struct NavigatorBarTitleWithBack: ViewModifier {

    private let title: String
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        NavigatorViewManager.shared.pop()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.neutral500)
                    }
                }
                ToolbarItem(placement: .principal) {
                    TextTitle(text: self.title, type: .small1, color: .dark)
                }
            }
    }
    
    init(title: String) {
        self.title = title
    }
}

struct NavigatorBarHidden: ViewModifier {
    
    private let title: String
        
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EmptyView()
                }
                ToolbarItem(placement: .principal) {
                    TextTitle(text: self.title, type: .small1, color: .dark)
                }
            }
    }
    
    init(title: String) {
        self.title = title
    }
}

struct NavigationBarModifier: ViewModifier {
    
    private let navBody: (AnyView) -> AnyView
    
    init<Brito: ViewModifier>(modifier: Brito) {
        self.navBody = { content in
            AnyView(content.modifier(modifier))
        }
    }
    
    func body(content: Content) -> some View {
        self.navBody(AnyView(content))
    }
}

enum NavigatorBarStyle {
    case hidden(String)
    case titleWithBack(String)
    case titleAndAction(NavigatorActionButton)
    
    var modifier: NavigationBarModifier {
        switch self {
        case .hidden(let title): NavigationBarModifier(modifier: NavigatorBarHidden(title: title))
        case .titleWithBack(let title): NavigationBarModifier(modifier: NavigatorBarTitleWithBack(title: title))
        case .titleAndAction(let action): NavigationBarModifier(modifier: NavigatorBarTitleAndAction(trailingAction: action))
        }
    }
}

extension View {
    func navigatorBarStyle(_ style: NavigatorBarStyle) -> some View {
        self.modifier(style.modifier)
    }
}
