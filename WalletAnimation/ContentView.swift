//
//  ContentView.swift
//  WalletAnimation
//
//  Created by Владислав Соколов on 04.12.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeAreaInsets = $0.safeAreaInsets
            
            Home(size: size, safeAreaInsets: safeAreaInsets)
                .ignoresSafeArea(.container, edges: .top)
        }
    }
}

#Preview {
    ContentView()
}
