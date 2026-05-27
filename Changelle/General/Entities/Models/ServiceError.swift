//
//  ServiceError.swift
//  DemoSwiftUI
//
// Created by Fernando Ortiz Escobar on 16/07/25.
//

import Combine

struct ServiceError: Error {
    
    //Tipo de error que nos va a llegar de la cabecera Http
    let reason: Reason
    
    //variable computada que vamos a devolver si no tenemos un tipo de error asignado
    var errorMessage: String {
        self.messages[self.reason] ?? "Ocurrio un error en la petición"
    }
    
    //Tipos de mensajes que vamos a mostrar segun los enum definidos anteriormente
    private let messages: [Reason: String] = [
        .badRequest: "Ocurrio un error en la petición",
        .unauthorized: "La sesión no esta autorizada para esta operación",
        .forbidden: "Ocurrio un error en la petición",
        .notFound: "No se encuentraron resultados para la búsqueda de:",
        .internalServiceError: "Información no disponible temporalmente, Inténtalo más tarde",
        .generic: "Ocurrio un error en la petición",
//        .save: "Error al guardar la pelicula a favoritos"
    ]
    
    //lo que llega cuando nos inicializan
    init(dto: ServiceErrorDTO) {
        self.reason = Reason(rawValue: dto.statusCode) ?? .generic
    }
}


//tipos de error defindos
extension ServiceError {
    enum Reason: Int {
        case badRequest = 400
        case unauthorized = 401
        case forbidden = 403
        case notFound = 404
        case internalServiceError = 500
        case generic = 0
        
//        case save = 701
    }
}


extension Publisher where Failure == ServiceErrorDTO {
    func mapServiceError() -> Publishers.MapError<Self, ServiceError> {
        self.mapError { error in
            ServiceError(dto: error)
        }
    }
}
