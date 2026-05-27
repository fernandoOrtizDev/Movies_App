//
//  ServiceErrorDTO.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 16/07/25.
//

import Combine

struct ServiceErrorDTO: Error {
    let statusCode: Int
    
    static var defaultError: ServiceErrorDTO {
        ServiceErrorDTO(statusCode: 0)
    }
}

extension Publisher where Failure == Error {

    func mapServiceErrorDTO() -> Publishers.MapError<Self , ServiceErrorDTO> {
        self.mapError { error in
            guard let error = error as? ServiceErrorDTO else {
                return ServiceErrorDTO(statusCode: 0)
            }
            return error
        }
    }
}
