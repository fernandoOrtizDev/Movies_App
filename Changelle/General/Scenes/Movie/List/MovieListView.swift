//
//  MovieListRouter.swift
//  Changelle
//
//  Created by Fernando Ortiz Escobar on 19/08/25.
//
import SwiftUI

struct MovieListView: View {
    
    @ObservedObject private var viewModel: MovieListViewModel
    private var strategy: any ViewProvider
    private var numberColumns: Int
    
    private func makeGridItems(columns: Int, spacing: CGFloat = 16) -> [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns)
    }

    var body: some View {
        self.contentView {
            Divider()
            self.searchView
            Divider()
            GenericList(status: viewModel.status, columns: makeGridItems(columns: self.numberColumns)) {
                strategy.makeView($0)}
            .isRefreshable(self.viewModel.allowPullToRefresh ? { self.viewModel.onPullToRefresh() } : nil)
                .onCellSelected { self.viewModel.onSelectMovie(movie: $0) }
                .errorView { CarListFeedbackView(messsage: $0, style: .error)}
                .loadingView {ContentLoadingView()}
                .emptyView {CarListFeedbackView(messsage: $0, style: .warning)}
                .onAppear { self.viewModel.onAppear() } 
        }
        .animation(.easeInOut, value: viewModel.currentSource)
    }
    
    
   
    init(viewModel: MovieListViewModel, strategy: any ViewProvider,numberColumns: Int ) {
        self.viewModel = viewModel
        self.strategy = strategy
        self.numberColumns = numberColumns
    }
}

extension MovieListView {
    private func contentView(@ViewBuilder view: @escaping () -> some View) -> some View {
        VStack {
            Spacer()
            view()
            Spacer()
        }
    }
    
    private var searchView: some View {
        HStack {
            SearchTextField(text: self.$viewModel.search)
        }
    }
}



#Preview {
    MoviesListViewBuilder.fromWebService.instance.build()
}
