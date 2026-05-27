//
//  MovieService.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 18/07/25.
//

import CoreData
import Combine

protocol MovieLocalStorageProtocol {
    func fetchAll() -> AnyPublisher<[Movie], ServiceError>
    func save(_ movies: [Movie])
    func delete(_ movie: Movie)
    func isFavorite(_ movie: Movie) -> Bool
    func fetchFiltered(by query: String) -> AnyPublisher<[Movie], ServiceError>

}

final class CoreDataFavoriteStorage: MovieLocalStorageProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    // MARK: - Fetch all favorites
    func fetchAll() -> AnyPublisher<[Movie], ServiceError> {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()

        return Future<[Movie], ServiceError> { promise in
            do {
                let favorites = try self.context.fetch(request)
                let movies = favorites.compactMap { Movie(id: $0.idMovie, title: $0.title, posterPath: $0.img, data: $0.releaseDate) }
                promise(.success(movies))
            } catch {
                print("Error fetching favorites: \(error)")
                promise(.success([]))
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    // MARK: - Save multiple movies as favorites
    func save(_ movies: [Movie]) {
        movies.forEach { movie in
            let favorite = Favorite(context: context)
            favorite.idMovie = String(movie.id)
            favorite.img = movie.posterPath
            favorite.title = movie.title
            favorite.releaseDate = movie.releaseDateShortFormat
        }
        saveContext()
    }

    // MARK: - Delete a favorite
    func delete(_ movie: Movie) {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "idMovie == %@", String(movie.id))

        do {
            let results = try context.fetch(request)
            results.forEach { context.delete($0) }
            saveContext()
        } catch {
            print("Error deleting favorite: \(error)")
        }
    }

    // MARK: - Check if a movie is already favorited
    func isFavorite(_ movie: Movie) -> Bool {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "idMovie == %@", String(movie.id))

        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Error checking favorite status: \(error)")
            return false
        }
    }

    // MARK: - Save context helper
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    } 
    
    func fetchFiltered(by query: String) -> AnyPublisher<[Movie], ServiceError> {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", query)

        return Future { promise in
            do {
                let results = try self.context.fetch(request)
                let movies = results.map {
                    Movie(id: $0.idMovie, title: $0.title, posterPath: $0.img, data: $0.releaseDate)
                }
                promise(.success(movies))
            } catch {
                promise(.failure(.init(dto: ServiceErrorDTO(statusCode: 0))))
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }


    
}
