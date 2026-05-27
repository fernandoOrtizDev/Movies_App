//
//  MovieInteractorBaseProtocol.swift
//  Changelle
//
//  Created by Fernando Ortiz Escobar on 19/08/25.
//
import Combine

protocol MovieInteractorBaseProtocol {
    func list(_ page: Int) -> AnyPublisher<[Movie], ServiceError>
    func filter(_ query: String, page: Int) -> AnyPublisher<[Movie], ServiceError>
}
