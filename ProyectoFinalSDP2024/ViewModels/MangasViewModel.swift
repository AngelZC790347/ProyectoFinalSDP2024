//
//  MangasViewModel.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 8/02/25.
//

import Foundation

@Observable
@MainActor
class MangasViewModel{
    @ObservationIgnored var repository:MangaRepository
    var mostDownloaded:[Manga] = []    
    init(repository: MangaRepository = MangaApiInteractor()) {
        self.repository = repository
        Task {
            mostDownloaded = try! await repository.getMangas(page: 1)
        }
    }
}
