//
//  GenericList.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 23/07/25.
//

import SwiftUI


struct GenericList<Item: Identifiable, Cell: View>: View {
    
    let columns : [GridItem]
    private var numberColumns: Int = 1
    
    private var status: GenericListStatus<Item> = .loading
    private let cell: (Item) -> Cell
    
    private var emptyView: ((String) -> AnyView)?
    private var errorView: ((String) -> AnyView)?
    private var loadingView: (() -> AnyView)?
    private var isRefreshable: (() -> Void)?
    private var onCellSelected: ((Item) -> Void)?
    
    init(status: GenericListStatus<Item>, columns: [GridItem] = [GridItem(.flexible(),spacing: Spacing._none)], cell: @escaping (Item) -> Cell ) {
        self.status = status
        self.cell = cell
        self.columns = columns
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
                    case .data(let items):
                        LazyVGrid(columns: self.columns, spacing: Spacing._md) {
                            ForEach(items) { item in
                                self.cell(item)
                                    .onTapGesture {
                                        self.onCellSelected?(item)
                                    }
                            }
                        }
                        .padding(.vertical, Spacing._sm)
                        .padding(.horizontal, Spacing._lg)
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
    
    func onCellSelected(_ value: ((Item) -> Void)?) -> Self {
        var view = self
        view.onCellSelected = value
        return view
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

enum GenericListStatus<Item: Identifiable>: Equatable {
    case loading
    case empty(message: String)
    case error(message: String)
    case data(items: [Item])
    
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
