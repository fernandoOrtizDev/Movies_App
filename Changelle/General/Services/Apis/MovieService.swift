//
//  MovieService.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 18/07/25.
//

import Foundation
import Combine
import Alamofire

//MARK: protocol
protocol MovieServiceProtocol {
    func executeWith(_ page: Int) -> AnyPublisher <WrapperDTO, ServiceErrorDTO>
}

//MARK: service
struct MovieService: MovieServiceProtocol {

    private func url(_ page: Int) -> String {
        let env = Environment.current
        let baseUrl = env.baseUrl
        let apiKey = env.apiKey
        let language = env.language.rawValue
        return "\(baseUrl)/movie/popular?api_key=\(apiKey)&language=\(language)&page=\(page)"
    }
    
    func executeWith(_ page: Int) -> AnyPublisher <WrapperDTO, ServiceErrorDTO> {
        AF.request(self.url(page),
                   method: .get,
                   encoding: JSONEncoding.default)
        .publishData()
        .tryMap{ responseData in
            try ServiceParse.decode(responseData)
        }
        .mapServiceErrorDTO()
        .eraseToAnyPublisher()
    }
}

//MARK: mock

struct MovieServiceMock {

    func executeWith(_ page: Int) -> AnyPublisher <[MovieDTO], ServiceErrorDTO> {
        Future{ promise in
            promise(.success([.mock,.mock,.mock,.mock,.mock,.mock,.mock,.mock,.mock,]))
        }
        .delay(for: .seconds(4), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}


struct MovieServiceMockFailure: MovieServiceProtocol {
    func executeWith(_ page: Int) -> AnyPublisher <WrapperDTO, ServiceErrorDTO> {
        Future{ promise in
            promise(.failure(.init(statusCode: 404)))
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
