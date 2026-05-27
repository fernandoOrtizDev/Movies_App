//
//  AppTaBarView.swift
//  Changelle
//
//  Created by Fernando Ortiz Escobar on 17/08/25.
//

import SwiftUI


struct AppTabBarView: View {
    
    @State private var selectedIndex: Int = 0
    private var items: [AppTabBarView.Item]
    
    var body: some View {
        VStack(spacing: Spacing._none) {
            TabView(selection: self.$selectedIndex) {
                ForEach(self.items.indices, id: \.self) { index in
                    self.items[index]
                        .view
                        .tag(index)
                }
            }
            AppTabBarView.TabBar(selectedIndex: self.$selectedIndex, items: self.items)
        }
    }
    
    init(items: [AppTabBarView.Item]) {
        self.items = items
        UITabBar.appearance().isHidden = true
    }
}

extension AppTabBarView {
    private struct TabBar: View {
        @Binding var selectedIndex: Int
        private var items: [AppTabBarView.Item]
        var body: some View {
            HStack {
                ForEach(self.items.indices, id: \.self) { index in
                    TabItem(item: self.items[index], index: index, selectedIndex: self.$selectedIndex)
                }
            }
        }
        
        init(selectedIndex: Binding<Int>, items: [AppTabBarView.Item]) {
            self._selectedIndex = selectedIndex
            self.items = items
        }
    }
    
    private struct TabItem: View {
        var item: AppTabBarView.Item
        var index: Int
        @Binding var selectedIndex: Int
        
        var body: some View {
            VStack(spacing: Spacing._md) {
                self.item.icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .foregroundStyle(self.index == self.selectedIndex ? self.item.selectedColor : self.item.unselectedColor)
                TextLabel(text: self.item.title, color: self.index == self.selectedIndex ? self.item.selectedColor : self.item.unselectedColor)
            }
            .frame(maxWidth: .infinity)
            .padding(Spacing._md)
            .onTapGesture {
                self.selectedIndex = self.index
            }
        }
    }
    
    struct Item: Identifiable {
        let id = UUID()
        let icon: Image
        let title: String
        let selectedColor: Color
        let unselectedColor: Color
        let view: AnyView
        
        init(view: AnyView, icon: Image, title: String, selectedColor: Color = .primary700, unselectedColor: Color = .neutral500) {
            self.view = view
            self.icon = icon
            self.title = title
            self.selectedColor = selectedColor
            self.unselectedColor = unselectedColor
        }
    }
}

#Preview {
//    AppTabBarView(items: [
//        AppTabBarView.Item(view: AnyView(MovieListView.buildFromWebService()), icon: Image(systemName: "square.grid.2x2.fill"), title: "General"),
//        
//        AppTabBarView.Item(view: AnyView(MovieListView.buildFromWebService()), icon: Image(systemName: "star.fill"), title: "Favoritas")
//    ])
}
