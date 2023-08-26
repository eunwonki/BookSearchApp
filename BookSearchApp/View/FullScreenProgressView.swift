//
//  FullScreenProgressView.swift
//  Metacellar
//
//  Created by Liam Eun on 2023/05/16.
//

import SwiftUI

struct FullScreenProgressView: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(.circular)
                .font(.largeTitle)
#if AVAILABLE
                .tint(.white)
#else
                .accentColor(.white)
#endif
                .scaleEffect(3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.7))
        .ignoresSafeArea()
    }
}

struct FullScreenProgressView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenProgressView()
    }
}

