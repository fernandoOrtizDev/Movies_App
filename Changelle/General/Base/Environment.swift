//
//  Environment.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 18/07/25.
//

import Foundation

class Environment {
    
    static let current = Environment()
    
    let apiKey = "176de15e8c8523a92ff640f432966c9c"
    let baseUrl = "https://api.themoviedb.org/3"
    var language: Language = .spanish
    
    private init() { }
}

extension Environment {
    enum Language: String {
        case spanish = "es-CO"
        case english = "en-CO"
    }
}
