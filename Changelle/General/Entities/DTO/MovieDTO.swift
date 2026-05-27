//
//  Movile.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 16/07/25.
//

import Foundation


struct MovieDTO: Decodable{
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
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


    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
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
    
    static var mock: MovieDTO{
        MovieDTO(
            adult: false,
            backdropPath: "/ovZasZ9EeZcp6UsrElkQ63hFCd.jpg",
            genreIds: [14 ,10751 ,28],
            id: 1087192,
            originalLanguage: "es",
            originalTitle: "Cómo entrenar a tu dragón ",
            overview: "En la escarpada isla de Mema, donde vikingos y dragones han sido enemigos acérrimos durante generaciones, Hipo se desmarca desafiando siglos de tradición cuando entabla amistad con Desdentao, un temido dragón Furia Nocturna. Su insólito vínculo revela la verdadera naturaleza de los dragones y desafía los cimientos de la sociedad vikinga.",
            popularity: 1018.8475,
            posterPath: "/9Zr7ZyiMpgMhhxJQi1tQJp9LGho.jpg",
            releaseDate: "2025-06-0",
            title:  "Cómo entrenar a tu dragón",
            video: false,
            voteAverage: 8.1 ,
            voteCount: 852
        )
    }
}
