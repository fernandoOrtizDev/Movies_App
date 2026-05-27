//
//  CarDetailView.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 30/07/25.
//
import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    
    @Published private(set) var status: GenericScrollStatus<MovieDetail> = .loading
    private let idMovie: Int
    private let interactor: MovieInteractorLocalProtocol
    private var task: AnyCancellable?
    @Published var isFavorite: Bool = false
    var favoriteIconName: String {
        isFavorite ? "star.fill" : "star"
    }

    
    
    var isMovieLoaded: Bool {
        if case .data = status { return true }
        return false
    }
    
    init(idMovie: Int, interactor: MovieInteractorLocalProtocol) {
        self.idMovie = idMovie
        self.interactor = interactor
    }
    
    deinit {
        self.task?.cancel()
    }
}

extension MovieDetailViewModel {
    func onPullToRefresh() {
        self.status = .loading
        self.getDetail()
    }
    func onAppear() {
        self.getDetail()
        loadFavoriteStatus()
    }
    
    func loadFavoriteStatus() {
        isFavorite = interactor.isFavorite(movieID: String(idMovie))
    }
    
    func toggleFavorite() {
        guard case let .data(movieDetail) = status else { return }
        let movie = Movie(
            id: String(idMovie),
            title: movieDetail.title,
            posterPath: movieDetail.posterPath,
            data: movieDetail.releaseDate?.toStringWith("yyyy-MM-dd") ?? ""
        )

        interactor.toggleFavorite(movie)
        loadFavoriteStatus()
    }



}

extension MovieDetailViewModel {
    private func getDetail() {
        self.task?.cancel()
        self.task = self.interactor
            .getMovieDetail(self.idMovie)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                defer { self?.task = nil }
                if case .failure(let error) = completion {
                    self?.status = .error(message: error.errorMessage)
                }
            } receiveValue: { [weak self] movie in
                self?.status = .data(item: movie)
            }
    }
}
