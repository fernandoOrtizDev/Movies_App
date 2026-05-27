//
//  MovieListNavRouter.swift
//  Changelle
//
//  Created by Fernando Ortiz Escobar on 19/08/25.
//

struct MovieListNavRouter: MovieListRouter {
    func goToMovieDetail(_ movie: Movie) {
        NavigatorViewManager.shared.push(movieDetailView.build(movie.id))
    }
}
