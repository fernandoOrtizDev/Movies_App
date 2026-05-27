//
//  MovieFilterService.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 18/07/25.
//

import Foundation
import Combine
import Alamofire

//MARK: protocol
protocol MovieFilterServiceProtocol{
    func executeWith(_ query: String, to page: Int) -> AnyPublisher <WrapperDTO, ServiceErrorDTO>
}

//MARK: service
struct MovieFilterService: MovieFilterServiceProtocol {
    
    private func url(_ query: String, page: Int) -> String {
        let env = Environment.current
        let baseUrl = env.baseUrl
        let apiKey = env.apiKey
        let language = env.language.rawValue
        return "\(baseUrl)/search/movie?api_key=\(apiKey)&query=\(query)&language=\(language)&page=\(page)"
    }
    
    func executeWith(_ query: String, to page: Int) -> AnyPublisher <WrapperDTO, ServiceErrorDTO> {
        AF.request(self.url(query, page: page),
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

struct MovieFilterServiceMock: MovieFilterServiceProtocol {
    
    private func url(_ query: String, page: Int) -> String {
        let env = Environment.current
        let baseUrl = env.baseUrl
        let apiKey = env.apiKey
        let language = env.language.rawValue
        return "\(baseUrl)/search/movie?api_key=\(apiKey)&query=\(query)&language=\(language)&page=\(page)"
    }
    
    func executeWith(_ query: String, to page: Int) -> AnyPublisher <WrapperDTO, ServiceErrorDTO> {
        AF.request(self.url(query, page: page),
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
