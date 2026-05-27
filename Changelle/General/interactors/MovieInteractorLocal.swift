//
//  MovieInteractorLocal.swift
//  Changelle
//
//  Created by Fernando Ortiz Escobar on 19/08/25.
//
import Combine
import Foundation
import CoreData

protocol MovieInteractorLocalProtocol:MovieInteractorBaseProtocol {
    func isFavorite(movieID: String) -> Bool
    func toggleFavorite(_ movie: Movie)
    func getMovieDetail(_ query: Int) -> AnyPublisher <MovieDetail, ServiceError>
    
}


final class MovieInteractorLocal: MovieInteractorLocalProtocol {
    private let storage: MovieLocalStorageProtocol
    private let movieDetailService: MovieDetailService

    private init(storage: MovieLocalStorageProtocol, movieDetailService: MovieDetailService) {
        self.storage = storage
        self.movieDetailService = movieDetailService
    }

    func isFavorite(movieID: String) -> Bool {
        let dummy = Movie(id: movieID, title: "", posterPath: "", data: "")
        return storage.isFavorite(dummy)
    }

    func toggleFavorite(_ movie: Movie) {
        if storage.isFavorite(movie) {
            storage.delete(movie)
        } else {
            storage.save([movie])
        }
    }

    
    func list(_ page: Int = 1) -> AnyPublisher<[Movie], ServiceError>{
        return storage.fetchAll()
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
    func filter(_ query: String, page: Int) -> AnyPublisher<[Movie], ServiceError> {
        storage.fetchFiltered(by: query)
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
    
    
}

extension MovieInteractorLocal {
    static func build() -> MovieInteractorLocalProtocol {
        let storage = CoreDataFavoriteStorage()
        let service = MovieDetailService() // Asegúrate de que este tenga un init disponible
        return MovieInteractorLocal(storage: storage, movieDetailService: service)
    }
}
