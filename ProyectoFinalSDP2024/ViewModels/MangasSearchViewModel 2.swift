//
//  MangasViewModel 2.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 9/02/25.
//

import SwiftUI


@Observable
@MainActor
class MangasSearchViewModel{
    @ObservationIgnored var repository:MangaRepository
    var showedMangas: [Manga] = []
    var selectedAuthor:Author?
    var selectedGenre :Genre?
    var selectedTheme: Theme?
    var selectedDemo:DemographicEnum?
     var searchString: String = ""

     init(repository: MangaRepository = MangaApiInteractor()) {
         self.repository = repository
         Task {
             showedMangas = try! await repository.getMostPouplarMangas(page: 1)
         }
     }

     func searchMangas() async {
         guard !searchString.isEmpty else {
             showedMangas = try! await repository.getMostPouplarMangas(page: 1) // Si no hay búsqueda, muestra los más populares
             return
         }
         showedMangas = try! await repository.searchMangaByQueryString(query: searchString, page: 1)
         if let author = selectedAuthor {
             showedMangas = showedMangas.filter { manga in
                 manga.authors.contains(author)
             }
         }
         if let genre = selectedGenre {
             showedMangas = showedMangas.filter { manga in
                 manga.genres.contains(genre)
             }
         }
         if let theme = selectedTheme {
             showedMangas = showedMangas.filter { manga in
                 manga.themes.contains(theme)   
             }
         }
     }
}
