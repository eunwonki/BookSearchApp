//
//  ContentView.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/25.
//

import SwiftUI
import ComposableArchitecture

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            SearchView(store: Store(
                initialState: BookSearch.State()) {
                BookSearch()
            })
        }
        .contentShape(Rectangle())
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
