//
//  MovieListFromServiceStrategy.swift
//  Changelle
//
//  Created by Fernando Ortiz on 19/08/25.

import Combine

struct MovieListFromServiceStrategy: MovieListStratey {
    
    private let interactor: MovieInteractor
    var allowPullToRefresh: Bool {true}
    
    init(interactor: MovieInteractor) {
        self.interactor = interactor
    }
    
    func getMovie() -> AnyPublisher<[Movie],ServiceError> {
        self.interactor
            .list(1)
            .eraseToAnyPublisher()
    }
}
