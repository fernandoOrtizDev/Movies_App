//
//  movieDetailService.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 13/08/25.
//

import Foundation
import Combine
import Alamofire


protocol MovieDetailServiceProtocol{
    func executeWith(_ query: Int) -> AnyPublisher <MovieDetailDTO, ServiceErrorDTO>
}

struct MovieDetailService: MovieDetailServiceProtocol {
    
    private func url(_ query: Int) -> String {
        let env = Environment.current
        let baseUrl = env.baseUrl
        let apiKey = env.apiKey
        let language = env.language.rawValue
        return "\(baseUrl)/movie/\(query)?api_key=\(apiKey)&language=\(language)"
    }
    
    func executeWith(_ query: Int) -> AnyPublisher <MovieDetailDTO, ServiceErrorDTO> {
        AF.request(self.url(query),
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


