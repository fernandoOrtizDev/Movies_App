//
//  NetworkService.swift
//  DemoSwiftUI
//
// Created by Fernando Ortiz Escobar on 16/07/25.

//Los DTO es como nos llega la informacion ya aqui mapiamos la informacion a como nosotros la queremos utilizar 

import Foundation

    struct Movie: Identifiable{
        let adult: Bool
        let backdropPath: String
        let genreIds: [Int]
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
        let prueba: String
        
        private var imageBaseUrl = "https://image.tmdb.org/t/p/w500"
        
        var imagen1: URL? {
                if !backdropPath.isEmpty {
                    return URL(string:"\(self.imageBaseUrl)\(self.backdropPath)")
                }
                return nil
            }
        
        var fimagen2: URL? {
                if !backdropPath.isEmpty {
                    return URL(string:"\(self.imageBaseUrl)\(self.posterPath)")
                }
                return nil
            }
        
        var releaseDateShortFormat: String {
            self.releaseDate?.toStringWith("dd MMM yyyy") ?? "Próximamente"
        }
        
        var releaseDateFullFormat: String {
            self.releaseDate?.toStringWith("EEEE dd 'de' MMMM 'del' yyyy") ?? "Próximamente"
        }
                
        init(dto: MovieDTO) {
            self.adult = dto.adult ?? false
            self.backdropPath = dto.backdropPath ?? ""
            self.genreIds = dto.genreIds ?? [0]
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
            self.prueba = dto.releaseDate ?? ""
        }
        
        init(id: String, title: String, posterPath: String, data: String) {
                self.id = Int(id) ?? 0
                self.title = title
                self.posterPath = posterPath
                self.backdropPath = posterPath
                self.adult = false
                self.genreIds = []
                self.originalLanguage = ""
                self.originalTitle = ""
                self.overview = ""
                self.popularity = 0
                self.releaseDate = data.toDateWith("yyyy-MM-dd")
                self.video = false
                self.voteAverage = 0
                self.voteCount = 0
                self.prueba = data
            }
        
    }
