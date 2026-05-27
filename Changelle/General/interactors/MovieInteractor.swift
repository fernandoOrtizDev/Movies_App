//
//  MovieInteractor.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 18/07/25.
//

import Combine

protocol MovieInteractorProtocol: MovieInteractorBaseProtocol {
 func getFavorites(_ query: String) -> AnyPublisher<[Movie], ServiceError>
 func getMovieDetail(_ query: Int) -> AnyPublisher <MovieDetail, ServiceError>
}

struct MovieInteractor: MovieInteractorProtocol {
    
    private let movieService: MovieServiceProtocol
    private let movieFilterService: MovieFilterServiceProtocol
    private let movieDetailService: MovieDetailService
    
    init(movieService: MovieServiceProtocol, movieFilterService: MovieFilterServiceProtocol, movieDetailService: MovieDetailService) {
        self.movieService = movieService
        self.movieFilterService = movieFilterService
        self.movieDetailService = movieDetailService
    }
   
    //TODO: deberia recibir un modelo y no una pagina
    func list(_ page: Int) -> AnyPublisher<[Movie], ServiceError> {
        self.movieService
            .executeWith(page)
            .map {
                $0.results?.map {
                    Movie(dto: $0)
                } ?? []
            }
            .mapServiceError()
            .eraseToAnyPublisher()
    }
    
    //TODO: deberia recibir un modelo y no el query y la pagina
    func filter(_ query: String, page: Int) -> AnyPublisher<[Movie], ServiceError> {
        self.movieFilterService
            .executeWith(query, to: page)
            .map {
                $0.results?.map {
                    Movie(dto: $0)
                } ?? []
            }
            .mapServiceError()
            .eraseToAnyPublisher()
    }
    
    func getMovieDetail(_ query: Int) -> AnyPublisher <MovieDetail, ServiceError> {
        self.movieDetailService
            .executeWith(query)
            .map {
               MovieDetail(dto: $0)
            }
            .mapServiceError()
            .eraseToAnyPublisher()
    }
    
    func getFavorites(_ query: String) -> AnyPublisher<[Movie], ServiceError> {
        self.movieFilterService
            .executeWith(query, to: 1)
            .map {
                $0.results?.map {
                    Movie(dto: $0)
                } ?? []
            }
            .mapServiceError()
            .eraseToAnyPublisher()
    }
}


extension MovieInteractor {
    static func build(_ typeData: TypeData) -> MovieInteractor {
        switch typeData {
        case .real:
            MovieInteractor(movieService: MovieService(), movieFilterService: MovieFilterService(), movieDetailService: MovieDetailService())
        case .mock:
            MovieInteractor(movieService: MovieService(), movieFilterService: MovieFilterService(), movieDetailService: MovieDetailService())
        }
    }
}
