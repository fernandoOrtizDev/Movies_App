//
//  Movie.swift
//  DemoSwiftUI
// Created by Fernando Ortiz Escobar on 16/07/25.
import Foundation

struct MovieDetail: Identifiable {
    let adult: Bool
    let backdropPath: String
    let genres: [MovieGenre] 
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: Date?
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    struct MovieGenre {
        let id: Int
        let name: String
    }
    
    private var imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    var imagen1: URL? {
        if !backdropPath.isEmpty {
            return URL(string: "\(self.imageBaseUrl)\(self.backdropPath)")
        }
        return nil
    }
    
    var fimagen2: URL? {
        if !posterPath.isEmpty {
            return URL(string: "\(self.imageBaseUrl)\(self.posterPath)")
        }
        return nil
    }
    
    var releaseDateShortFormat: String {
        self.releaseDate?.toStringWith("dd MMM 'del' yyyy") ?? "Próximamente"
    }
    
    var releaseDateFullFormat: String {
        self.releaseDate?.toStringWith("EEEE dd 'de' MMMM 'del' yyyy") ?? "Próximamente"
    }
    
    init(dto: MovieDetailDTO) {
        self.adult = dto.adult ?? false
        self.backdropPath = dto.backdropPath ?? ""
        if let dtoGenres = dto.genres {
            self.genres = dtoGenres.compactMap { dtoGenre in
                if let id = dtoGenre.id, let name = dtoGenre.name {
                    return MovieGenre(id: id, name: name)
                }
                return nil
            }
        } else {
            self.genres = []
        }
        self.id = dto.id ?? 0
        self.originalLanguage = dto.originalLanguage ?? ""
        self.originalTitle = dto.originalTitle ?? ""
        self.overview = dto.overview ?? ""
        self.popularity = dto.popularity ?? 0
        self.posterPath = dto.posterPath ?? ""
        self.releaseDate = dto.releaseDate?.toDateWith("yyyy-MM-dd")
        self.title = dto.title ?? ""
        self.video = dto.video ?? false
        self.voteAverage = dto.voteAverage ?? 0
        self.voteCount = dto.voteCount ?? 0
    }
}
