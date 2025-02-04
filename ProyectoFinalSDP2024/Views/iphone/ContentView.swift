//
//  ContentView.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 7/12/24.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
            NavigationStack {
                ScrollView(.horizontal, showsIndicators: false) {
                
                    
                }
                .navigationTitle(Text("AnimeSB"))
                .toolbar {
                    ToolbarItem {
                        ToolBarMenu()
                    }
                }
            }
            .tint(.primarySB)
            .padding()
        }
}

#Preview {
    ContentView()
}
