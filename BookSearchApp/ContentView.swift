//
//  ContentView.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/25.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}

struct ContentView: View {
    @EnvironmentObject var configuration: Configuration
    
    var body: some View {
        NavigationView {
            SearchView(model: .init(
                provider: configuration.provider))
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
            .environmentObject(Configuration(.preview))
    }
}
