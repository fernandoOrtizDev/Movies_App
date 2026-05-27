//
//  movilViewCell.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 25/07/25.
//

import SwiftUI

protocol ViewProvider {
    
    func makeView(_ movie: Movie) -> AnyView
}

struct genericMovieView: ViewProvider {

    func makeView(_ movie: Movie) -> AnyView {
        AnyView(
            contentView {
                imageMovie(movie)
                movieInfoView {
                    titleLabel(movie)
                    releaseDateLabel(movie)
                    ratingStars(movie)
                }
                Spacer()
            }
        )
    }
    
    private func contentView(@ViewBuilder view: @escaping () -> some View) -> some View {
        HStack(alignment: .top) {
            view()
        }
        .background(Color("CardBackground"))
        .cornerRadius(15)
        .overlay(RoundedRectangle(cornerRadius: 12)
            .stroke(Color .neutral100, lineWidth: 2))
    }
    
    private func movieInfoView(@ViewBuilder view: @escaping () -> some View) -> some View {
        VStack(alignment: .leading) {
            view()
        }
    }
    
    private func imageMovie(_ movie: Movie) -> some View {
        AsyncImage(url: movie.fimagen2) { image in
            image.resizable().aspectRatio(contentMode: .fill)
        } placeholder: {
            Color.gray.opacity(0.3)
        }
        .frame(width: 100, height: 150)
        .clipped()
        .cornerRadius(8)
    }
    
    private func titleLabel(_ movie: Movie) -> some View {
        TextTitle(text: movie.title, type: .small)
            .padding(.bottom, 5)
            .padding(.top, 3)
    }
    
    private func releaseDateLabel(_ movie: Movie) -> some View {
        VStack(alignment: .leading) {
            TextCaption(text: "Fecha de lanzamiento:", color: .text).italic()
            TextCaption(text: movie.releaseDateFullFormat, color: .text).italic().padding(.bottom, 5)
        }
    }
    
    private func ratingStars(_ movie: Movie) -> some View {
        let rating = Int((movie.voteAverage / 1.0).rounded())
        return HStack(spacing: 2) {
            ForEach(0..<10) { index in
                Image(systemName: index < rating ? "star.fill" : "star")
                    .foregroundColor(Color("StarColor"))
            }
        }
    }
}


struct favoritesMovieView: ViewProvider {

    func makeView (_ movie: Movie) -> AnyView {
        AnyView(
            VStack {
                AsyncImage(url: movie.fimagen2) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 200,maxHeight: 150)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 180, height: 250)
                .cornerRadius(12)

                TextCaption(text: movie.title)
                    .foregroundStyle(Color("TextPrimary"))
                    .font(.system(size: 20))
                    .frame(width: 180)
                TextCaption(text: movie.releaseDateShortFormat)
                    .foregroundStyle(Color("TextSecondary"))
                    .font(.system(size: 15))
            }
                .frame(minWidth: 150,minHeight: 350)
                .frame(maxWidth: 150,maxHeight: 350)
        )
    }

}

//#Preview {
//    genericMovieView().makeView(Movie(dto: MovieDTO.mock))
//}
//
#Preview {
    favoritesMovieView().makeView(Movie(id: "1087192", title: "Cómo entrenar a tu dragón", posterPath: "/9Zr7ZyiMpgMhhxJQi1tQJp9LGho.jpg", data: "2025-06-05"))
}
