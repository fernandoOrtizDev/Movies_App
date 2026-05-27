//
//  MoviesListViewFromoServiceBilder.swift
//  Changelle
//
//  Created by Fernando Ortiz Escobar on 19/08/25.
//

import SwiftUI

struct MoviesListViewFromoServiceBilder: MoviesListViewBuilderProtocol {
    
    private let typeData: TypeData
    
    init(typeData: TypeData = .real) {
        self.typeData = typeData
    }
    
    
    var viewModel: MovieListViewModel {
        let interactor = MovieInteractor.build(.real)
        let strategy = MovieListFromServiceStrategy(interactor: interactor)
        let router = MovieListNavRouter()
        var filterStrategy = MovListFilterWebServiceStrategy()
        filterStrategy.interactor = interactor
        return MovieListViewModel(listStrategy: strategy, filterStrategy: filterStrategy, router: router, interactor: interactor)
    }
    
    func build() -> any View {
        return  MovieListView(viewModel: self.viewModel, strategy: genericMovieView(), numberColumns: 1)
    }
    
    
}
