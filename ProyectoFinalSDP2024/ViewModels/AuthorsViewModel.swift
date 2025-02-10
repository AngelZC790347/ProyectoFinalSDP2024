//
//  AuthorsViewModel.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 9/02/25.
//

import SwiftUI

@Observable
class AuthorsViewModel{
    @ObservationIgnored var repository:AuthorRepository
    var authors:[Author] = []
    var genres:[Genre] = []
    var themes:[Theme] = []
    var searchString = ""
    init(repository: AuthorRepository) {
        self.repository = repository
        Task{
            authors = try await self.repository.getAuthors()
            genres = try await self.repository.getGenres()
            themes = try await self.repository.getThemes()
        }
    }
}
