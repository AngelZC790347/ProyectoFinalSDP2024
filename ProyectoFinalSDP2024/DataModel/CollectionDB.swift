//
//  Manga.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 8/02/25.
//
import Foundation
import SwiftData

enum DataError: Error {
    case notFound
}

@Model
final class CollectionDB{
    @Attribute(.unique) var id:String
    var completeCollection: Bool
    var readingVolume: Int
    var user: UserId
    var mangaData:Data
    var manga: Manga? {
            try? JSONDecoder().decode(Manga.self, from: mangaData)
    }
    var volumesOwned: [Int]
    init(id: String, completeCollection: Bool, readingVolume: Int, user: UserId, manga: Manga, volumesOwned: [Int]) throws{
        self.id = id
        self.completeCollection = completeCollection
        self.readingVolume = readingVolume
        self.user = user
        self.mangaData =  try JSONEncoder().encode(manga)
        self.volumesOwned = volumesOwned
    }
    func toPrimitive(repository:MangaRepository = MangaApiInteractor()) ->  CollectionManga{
        CollectionManga(
                   completeCollection: completeCollection,
                   readingVolume: readingVolume,
                   user: user,
                   manga: manga?.toValueObj() ?? .preview,
                   volumesOwned: volumesOwned,
                   id: id
       )
        
    }
    
}



