//
//  MovieListFromDataBaseStrategyv.swift
//  Changelle
//
//  Created by Daniel Stiven Britto Argote on 19/08/25.
//

import Combine

struct MovieListFromDataBaseStrategy: MovieListStratey {
    
    private let interactor: MovieInteractorLocalProtocol
    var allowPullToRefresh: Bool {false}
    
    init(interactor: MovieInteractorLocalProtocol) {
        self.interactor = interactor
    }
    
    func getMovie() -> AnyPublisher<[Movie],ServiceError> {
        self.interactor
            .list(1)    
    }
}
