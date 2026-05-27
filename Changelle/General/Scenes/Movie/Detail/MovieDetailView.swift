//
//  CarDetailView.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 30/07/25.
//

import SwiftUI

struct movieDetailView: View {
    @ObservedObject private var viewModel: MovieDetailViewModel
    var body: some View {
        GenericScroll(status: self.viewModel.status) { self.movieDetailContent($0) }
            .loadingView { ContentLoadingView() }
            .errorView { CarListFeedbackView(messsage: $0, style: .error) }
//            .isRefreshable { self.viewModel.onPullToRefresh() }
            .onAppear { self.viewModel.onAppear()}
            
    }
    
    fileprivate init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
    }
}

extension movieDetailView {
    private func movieDetailContent(_ movie: MovieDetail) -> some View {
        VStack(spacing: Spacing._lg) {
            self.contentView {
                VStack{
                    HStack(alignment: .top, spacing: Spacing._md) {
                        AsyncImage(url: movie.fimagen2) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 120, height: 150)
                        .clipped()
                        .padding(.leading)

                        VStack(alignment: .leading, spacing: Spacing._xs) {
                            TextTitle(text: movie.title,type: .small,color: .cardBackground)
                                .foregroundStyle(Color("TextPrimary"))
                                .lineLimit(2)
                            VStack(alignment: .leading, spacing: 2) {
                                TextCaption(text: "Fecha de lanzamiento:",color: .bold, type: .bold1).italic()
                                TextCaption(text: movie.releaseDateFullFormat,color: .bold, type: .bold1).italic().padding(.bottom,5)
                                
                                ratingStars(movie: movie)
                                
                            }
                        }

                        Spacer()
                    }
                    .frame(height: 200)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.8), Color.gray.opacity(0.4)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    
                    VStack(alignment: .leading, spacing: Spacing._xs){
                        Text("Géneros:")
                            .font(.headline)
                        Text(movie.genres.map { $0.name}.joined(separator: " • "))
                            .font(.system(size: 15))
                            .italic()
                        .foregroundColor(Color("TextSecondary"))
                        Spacer( minLength: Spacing._lg)
                        
                        Text("Descripción:")
                            .font(.headline)

                        Text(movie.overview)
                            .font(.system(size: 13))
                            .italic()
                            .foregroundColor(Color("TextSecondary"))
                    }.padding(.horizontal, Spacing._md)
                    
                }
               
            }
        }
        
    }
    
    private func contentView(@ViewBuilder view: @escaping () -> some View) -> some View {
        HStack(alignment: .top, spacing: Spacing._sm) { view() }
            .background(.neutral50)

    }
    
    private func ratingStars(movie: MovieDetail)-> some View {
        
        let rating = Int((movie.voteAverage / 1.0).rounded())
        return HStack(spacing: 2) {
            ForEach(0..<10) { index in
                Image(systemName: index < rating ? "star.fill" : "star")
                    .foregroundColor(Color("StarColor"))
                    .font(.system(size: 13))
            }
        }
    }
    
}

extension movieDetailView {
    static func build(_ idMMovie: Int) -> NavigatorScreen {
        let interactor = MovieInteractorLocal.build()
        let viewModel = MovieDetailViewModel(idMovie: idMMovie, interactor: interactor)
        let action = NavigatorActionButton(
            title: viewModel.isFavorite ? "star.full" : "star"
        ) {
            viewModel.toggleFavorite()
        }

        let view = movieDetailView(viewModel: viewModel)
            .navigatorBarStyle(.titleAndAction(action))
        return NavigatorScreen(view: view)
    }
    
    static func buildMock(_ idMMovie: Int) -> some View {
        let interactor = MovieInteractorLocal.build()
        let viewModel = MovieDetailViewModel(idMovie: idMMovie, interactor: interactor)
         let view = movieDetailView(viewModel: viewModel)
            .navigatorBarStyle(.titleWithBack("Detalle Película"))
        return view
    }
}

#Preview {
    movieDetailView.build(9999).view
}
