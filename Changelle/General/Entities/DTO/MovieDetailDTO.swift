//
//  MovieDetailDTO.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 13/08/25.
//
import Foundation

struct MovieDetailDTO: Decodable {
    let adult: Bool?
    let backdropPath: String?
    let genres: [GenreDTO]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    struct GenreDTO: Decodable {
        let id: Int?
        let name: String?
    }
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genres
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    static var mock: MovieDetailDTO {
        MovieDetailDTO(
            adult: false,
            backdropPath: "/zNriRTr0kWwyaXPzdg1EIxf0BWk.jpg",
            genres: [
                GenreDTO(id: 878, name: "Ciencia ficción"),
                GenreDTO(id: 12, name: "Aventura"),
                GenreDTO(id: 28, name: "Acción")
            ],
            id: 1234821,
            originalLanguage: "en",
            originalTitle: "Jurassic World Rebirth",
            overview: "Cinco años después de los eventos de \"Dominion\", la ecología del planeta ha demostrado ser insoportable para los dinosaurios, donde los pocos que quedan viven aislados en las regiones ecuatoriales. Zora Bennett es contratada para dirigir a un equipo de especialistas cuyo objetivo es conseguir el material genético de las tres criaturas más grandes, las cuales tienen en su ADN la clave para fabricar un medicamento que aportará grandes beneficios a la humanidad. Pero la operación se cruzará con una familia cuyo barco volcó y todos acabarán en una isla prohibida ocupada por dinosaurios de numerosas especies, donde tendrán que hacer lo imposible para sobrevivir.",
            popularity: 1090.5346,
            posterPath: "/v49ceVcpW4Vj0tveTWlzrRdsFf4.jpg",
            releaseDate: "2025-07-01",
            title: "Jurassic World: El renacer",
            video: false,
            voteAverage: 6.39,
            voteCount: 1467
        )
    }
}
