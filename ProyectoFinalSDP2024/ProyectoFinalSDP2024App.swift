//
//  ProyectoFinalSDP2024App.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 7/12/24.
//

import SwiftUI

@MainActor let isIpad = UIDevice.current.userInterfaceIdiom == .pad

@main
struct ProyectoFinalSDP2024App: App {

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if isIpad {
                    ContentViewIpad()
                }else{
                    ContentView()
                }
            }

            
        }
    }
}
