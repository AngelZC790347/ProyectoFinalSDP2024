//
//  ToolBarMenu.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 18/01/25.
//
import SwiftUI
struct ToolBarMenu:View{
    var body: some View{        
            Menu {
                Button("Opción 1") {
                    print("Opción 1 seleccionada")
                }
                Button("Opción 2") {
                    print("Opción 2 seleccionada")
                }
                Button("Opción 3") {
                    print("Opción 3 seleccionada")
                }
            } label: {
                Label("Menu", systemImage: "ellipsis.circle").foregroundStyle(.primarySB)
            }
    }
    
}

#Preview {
    ToolBarMenu()
}
