//
//  CollectionViewModel.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 8/02/25.
//
import SwiftUI
@Observable
class CollectionViewModel{
    @ObservationIgnored let repository:CollectionRepository
    var collection:[CollectionManga] = []{
        didSet{
            
        }
    }
    init(repository: CollectionRepository) {
        self.repository = repository
        Task{
            self.collection = try await repository.getCollections()
        }
    }
}
