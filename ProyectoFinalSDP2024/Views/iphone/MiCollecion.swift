//
//  MiCollecion.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 6/02/25.
//

import SwiftUI
import SwiftData

struct MiCollecion: View {
    @State var collectionVM:CollectionViewModel
    @Environment(\.modelContext) var mo
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach($collectionVM.collection) { $collection in
                        NavigationLink {
                            CollectionEditView(collection: $collection, collectionRepository: CollectionDataBaseInteractor(modelContext: mo))
                        } label: {
                            CollectionCard(collection: $collection.wrappedValue)
                        }

                    }
                }
                .padding()
            }.navigationTitle("Mi Collecion").toolbar {
                ToolBarMenu()
            }
        }.tint(.primarySB)
        
    }
}

#Preview {
    MiCollecion(collectionVM: CollectionViewModel(repository: CollectionMockInteractor()))
}
