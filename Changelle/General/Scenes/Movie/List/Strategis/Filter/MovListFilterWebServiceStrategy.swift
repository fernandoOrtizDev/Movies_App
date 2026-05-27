//
//  MovListFilterLocalStorageStrategy.swift
//  Changelle
//
//  Created by Fernando Ortiz on 19/08/25.
//

import Combine

struct MovListFilterWebServiceStrategy: MovieListFilterStrategy {
    var interactor: MovieInteractor? = nil  // ✅ ahora es mutable y opcional
    
    var textPlaceholder: String { "Búsqueda local" }
    
    init() { }  // ✅ puedes crear la instancia sin parámetros
    
    func emptyMessage(for query: String) -> String {
        "No se encuentran resultados para:\n\n\(query)"
    }
    
    func filterList(query: String, page: Int) -> AnyPublisher<[Movie], ServiceError> {
        guard let interactor else {
            return Fail(error: ServiceError(dto: ServiceErrorDTO(statusCode: 0)))
                .eraseToAnyPublisher()
        }
        return interactor.filter(query, page: page)
    }
}


