//
//  GenericList.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 23/07/25.
//

import SwiftUI

struct GenericScroll<Item: Identifiable, ContentView: View>: View {
    
    private let columns = [GridItem(.flexible(), spacing: Spacing._none)]
    
    private var status: GenericScrollStatus<Item> = .loading
    private let contentView: (Item) -> ContentView
    
    private var emptyView: ((String) -> AnyView)?
    private var errorView: ((String) -> AnyView)?
    private var loadingView: (() -> AnyView)?
    private var isRefreshable: (() -> Void)?
    
    init(status: GenericScrollStatus<Item>, contentView: @escaping (Item) -> ContentView) {
        self.status = status
        self.contentView = contentView
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                Group {
                    switch self.status {
                    case .loading:
                        self.loadingView?()
                            .transition(.opacity)
                    case .empty(let message):
                        self.emptyView?(message)
                            .frame(height: proxy.size.height)
                            .transition(.opacity)
                    case .error(let message):
                        self.errorView?(message)
                            .transition(.opacity)
                            .frame(height: proxy.size.height)
                    case .data(let item):
                        self.contentView(item)
                            .transition(.opacity)
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: self.status)
                
            }
            .scrollIndicators(.hidden)
            .ignoresSafeArea(.container, edges: .bottom)
            .conditionalRefreshable(self.isRefreshable)
        }
    }
    
    func emptyView(_ value: @escaping (String) -> some View) -> Self {
        var view = self
        view.emptyView = { AnyView(value($0)) }
        return view
    }
    
    func errorView(_ value: @escaping (String) -> some View) -> Self {
        var view = self
        view.errorView = { AnyView(value($0)) }
        return view
    }
    
    func loadingView(_ value: @escaping () -> some View) -> Self {
        var view = self
        view.loadingView = { AnyView(value()) }
        return view
    }
    
    func isRefreshable(_ value: (() -> Void)?) -> Self {
        var view = self
        view.isRefreshable = value
        return view
    }
}

fileprivate extension View {
    @ViewBuilder
    func conditionalRefreshable(_ action: (() -> Void)?) -> some View {
        if let action = action {
            self.refreshable { action() }
        } else {
            self
        }
    }
}

enum GenericScrollStatus<Item: Identifiable>: Equatable {
    case loading
    case empty(message: String)
    case error(message: String)
    case data(item: Item)
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading),
             (.empty, .empty),
             (.error, .error),
             (.data, .data): true
        default: false
        }
    }
}
