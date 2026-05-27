//
//  WrapperDTO.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 16/07/25.
//

import Foundation

struct WrapperDTO: Decodable {
    let page: Int?
    let results: [MovieDTO]?
    let total_pages: Int?
    let total_results: Int?
    
    static var mock: WrapperDTO{
        WrapperDTO(
            page: 1,
            results: [MovieDTO.mock],
            total_pages: 51468,
            total_results: 1029342
        )
    }
}
