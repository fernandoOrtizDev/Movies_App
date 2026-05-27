//
//  MovieListStratey.swift
//  Changelle
//
//  Created by Daniel Stiven Britto Argote on 18/08/25.
//
import Combine

protocol MovieListStratey {
    var allowPullToRefresh: Bool {get}
    func getMovie() -> AnyPublisher<[Movie],ServiceError>
}
