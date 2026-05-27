//
//  MovieListFilterStrategy.swift
//  Changelle
//
//  Created by Fernando Ortiz on 19/08/25.
//

import Combine

protocol MovieListFilterStrategy {
    var textPlaceholder: String { get }
    func emptyMessage(for query: String) -> String
    func filterList(query: String, page: Int) -> AnyPublisher<[Movie], ServiceError>
}

