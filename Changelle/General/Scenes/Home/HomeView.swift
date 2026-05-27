//
//  HomeView.swift
//  Changelle
//
//  Created by Fernando Ortiz Escobar on 18/08/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        AppTabBarView(items: [
            AppTabBarView.Item(view: AnyView(MoviesListViewBuilder.fromWebService.instance.build()),
                               icon: Image(systemName: "square.grid.2x2"),
                               title: "General"),
            AppTabBarView.Item(view: AnyView(MoviesListViewBuilder.fromDataBase.instance.build()),
                               icon: Image(systemName: "star"),
                               title: "Favoritas")
        ])
    }
}

extension HomeView {
    static func build() -> NavigatorScreen {
        let view = HomeView()
            .navigatorBarStyle(.hidden("CineMark"))
        return NavigatorScreen(view: view)
    }
}

