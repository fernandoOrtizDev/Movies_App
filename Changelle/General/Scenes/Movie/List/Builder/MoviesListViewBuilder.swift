//
//  MovieListViewBuilder.swift
//  Changelle
//
//  Created by Fernando Ortiz Escobar on 19/08/25.
//

import SwiftUI

enum MoviesListViewBuilder {
    case fromWebService
    case fromDataBase
    var  instance: MoviesListViewBuilderProtocol {
        switch self {
        case .fromWebService:
            MoviesListViewFromoServiceBilder()
        case .fromDataBase:
            MoviesListViewFromoDataBaseBilder()
        }
    }
    
    var  instanceMock: MoviesListViewBuilderProtocol {
        switch self {
        case .fromWebService:
            MoviesListViewFromoServiceBilder(typeData: .mock)
        case .fromDataBase:
            MoviesListViewFromoDataBaseBilder(typeData: .mock)
        }
    }
}

protocol MoviesListViewBuilderProtocol {
    func build() -> any View

}
