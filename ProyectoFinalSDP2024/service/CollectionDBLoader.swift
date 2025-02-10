//
//  MangaDBLoader.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 8/02/25.
//

import SwiftData



class CollectionDBLoader{
    let repository:CollectionRepository
    init(repository: CollectionRepository) {
        self.repository = repository
    }
    
    @MainActor
    func loadData(context:ModelContext) async throws{
        let collections = try await self.repository.getCollections()
        try collections.forEach { collection in
            let manga = collection.manga
            try context.insert(CollectionDB(id: collection.id, completeCollection: collection.completeCollection, readingVolume: collection.readingVolume, user: collection.user, manga: manga.toValueObj(), volumesOwned: collection.volumesOwned))
        }
    }
}
