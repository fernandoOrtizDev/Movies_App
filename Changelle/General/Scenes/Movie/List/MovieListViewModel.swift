//
//  MovieListRouter.swift
//  Changelle
//
//  Created by Fernando Ortiz Escobar on 19/08/25.
//
import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    
    @Published private(set) var status: GenericListStatus<Movie> = .loading
    @Published private(set) var isRefreshable = false
    @Published var search: String = ""
    
    
    @Published var currentSource: MovieSource = .general {
        didSet {loadMovies()}
    }
    
    var allowPullToRefresh: Bool { self.listStrategy.allowPullToRefresh }
    var searchPlaceHolder: String { self.filterStrategy.textPlaceholder }
    
    private let listStrategy: MovieListStratey
    private let filterStrategy: MovieListFilterStrategy
    private let router: MovieListRouter

    private let interactor: MovieInteractorBaseProtocol
    private var task: AnyCancellable?
    private var taskFilter: AnyCancellable?
    
    init(listStrategy: MovieListStratey,
         filterStrategy: MovieListFilterStrategy,
         router: MovieListRouter,interactor: MovieInteractorBaseProtocol) {
        self.listStrategy = listStrategy
        self.filterStrategy = filterStrategy
        self.router = router
        self.interactor = interactor
        setupSearchObserver()
    }
    
    deinit{
        self.task?.cancel()
        self.taskFilter?.cancel()
    }
    
    
    
    private func setupSearchObserver() {
           self.taskFilter = $search
               .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
               .removeDuplicates()
               .sink { [weak self] _ in
                   self?.loadMovies()
               }
       }
    
}
extension MovieListViewModel{
    func onPullToRefresh(){
        self.status = .loading
        self.loadMovies()
    }
    
    func onAppear(){
        self.loadMovies()

    }
    
    func onSelectMovie(movie: Movie){
        self.router.goToMovieDetail(movie)
    }
}

extension MovieListViewModel {
        private func showLoading(_ isShow: Bool) {
            LoadingViewManager.shared.show = isShow
        }
}

extension MovieListViewModel {
    
    func loadMovies() {
        if search.isEmpty {
            getAll()
        } else {
            filter()
        }
    }


    enum MovieSource {
            case general
            case favorites
        }
    
}

extension MovieListViewModel {
    private func getAll() {
        self.task?.cancel()
        self.task = self.listStrategy
            .getMovie()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                defer { self?.task = nil }
                if case .failure(let error) = completion {
                    self?.status = .error(message: error.errorMessage)
                }
            } receiveValue: { [weak self] movies in

                self?.status = movies.isEmpty ? .empty(message: "La información no se encuentra disponible en este momento") : .data(items: movies)
            }
    }
    
    func filter() {
        task?.cancel()
        showLoading(true)
        taskFilter = self.filterStrategy
            .filterList(query: search, page: 1)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.showLoading(false)
                if case .failure(let error) = completion {
                    self?.status = .error(message: error.errorMessage)
                }
            } receiveValue: { [weak self] movies in
                guard let self = self else { return }
                self.status = movies.isEmpty
                    ? .empty(message: self.filterStrategy.emptyMessage(for: self.search))
                    : .data(items: movies)
            }
    }

}
