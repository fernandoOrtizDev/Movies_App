//
//  ServiceParse.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 16/07/25.
//

import Alamofire
import Foundation



struct ServiceParse<T: Decodable> {

    static func decode(_ responseData: DataResponsePublisher<Data>.Output) throws -> T  {
        
        guard let statusCode = responseData.response?.statusCode else {
            throw ServiceErrorDTO(statusCode: 0)
        }
        
        guard let data = responseData.data else {
            throw ServiceErrorDTO(statusCode: statusCode)
        }
        
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            return response
        } catch {
            throw error
        }
    }
}

