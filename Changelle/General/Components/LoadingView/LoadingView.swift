//
//  LoadingView.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 26/07/25.
//

import SwiftUI
import Lottie

struct LoadingView: View {
    @ObservedObject private var manager = LoadingViewManager.shared
    var body: some View {
        if self.manager.show {
            ZStack{
                Color.black.opacity(0.1)
                    .edgesIgnoringSafeArea(.all)
                LottieView(animation: .named("Loading"))
                    .playing(loopMode: .loop)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 450,height: 450)
                
            }.transition(.opacity)
                .animation(.default,value: self.manager.show)
        }
    }
}

final class LoadingViewManager: ObservableObject {
    static let shared = LoadingViewManager()
    @Published var show: Bool = true
    private init() {}
}


struct ContentLoadingView: View {
    var body: some View {
        HStack{
            Spacer()
            LottieView(animation: .named("Loading"))
                .playing(loopMode: .loop)
                .aspectRatio(contentMode: .fill)
                .frame(width: 150,height: 150)
            Spacer()
        }
    }
}

#Preview {
    LoadingView()
}
