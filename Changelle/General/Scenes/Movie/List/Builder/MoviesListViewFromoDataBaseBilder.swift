//
//  MoviesListViewFromoDataBaseBilder.swift
//  Changelle
//
//  Created by Fernando Ortiz Escobar on 19/08/25.
//

import SwiftUI

struct MoviesListViewFromoDataBaseBilder: MoviesListViewBuilderProtocol {
    
    private let typeData: TypeData
    
    init(typeData: TypeData = .real) {
        self.typeData = typeData
    }
    
    var viewModel: MovieListViewModel {
        let interactor = MovieInteractorLocal.build()
        let strategy = MovieListFromDataBaseStrategy(interactor: interactor)
        let router = MovieListNavRouter()
        let filterStrategy = MovListFilterLocalStorageStrategy()
        return MovieListViewModel(listStrategy: strategy, filterStrategy: filterStrategy, router: router,interactor: interactor)
    }
    
    func build() -> any View {
        return  MovieListView(viewModel: self.viewModel, strategy: favoritesMovieView(), numberColumns: 2)
    }
}
