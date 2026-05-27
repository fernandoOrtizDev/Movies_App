//
//  CarListFilterCarNameStrategy.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 4/08/25.
//
import Combine
struct MovListFilterLocalStorageStrategy: MovieListFilterStrategy {

    let storage = MovieInteractorLocal.build()
    
    var textPlaceholder: String { "Búsqueda local" }
    
    func emptyMessage(for query: String) -> String {
        "No se encuentran resultados para:\n\n\(query)"
    }
    
    func filterList(query: String, page: Int) -> AnyPublisher<[Movie], ServiceError> {
        storage.filter(query, page: page)
    }

}

