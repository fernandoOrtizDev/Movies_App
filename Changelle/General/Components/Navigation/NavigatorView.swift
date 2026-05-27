//
//  NavigatorView.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 22/07/25.
//

import SwiftUI

struct NavigatorView: View {
    
    @StateObject private var manager = NavigatorViewManager.shared
    private var root: NavigatorScreen
   
    init(root: NavigatorScreen) {
        self.root = root
    }
    
   var body: some View {
       NavigationStack(path: self.$manager.path) {
           self.root.view
               .navigationDestination(for: NavigatorScreen.self) { screen in
                   screen.view
               }
        }
   }
}


final class NavigatorViewManager: ObservableObject {
    static let shared = NavigatorViewManager()
    
    @Published fileprivate var path:NavigationPath = NavigationPath()
    
    private init () { }
    
    func push(_ screen:NavigatorScreen) {
        self.path.append(screen)
    }
    
    func pop() {
        self.path.removeLast()
    }
}


