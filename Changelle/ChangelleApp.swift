//
//  DemoSwiftUIApp.swift
//  DemoSwiftUI
//
//  Created by Fernando Ortiz Escobar on 28/05/25.
//

import SwiftUI

@main
struct DemoSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigatorView(root: HomeView.build())
            }
            
        }
    }
}

