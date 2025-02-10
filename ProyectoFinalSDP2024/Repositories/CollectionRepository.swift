//
//  CollectionRepository.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 8/02/25.
//

import Foundation
import SwiftData

protocol CollectionRepository{
    var authToken: String? { get }
    func getCollections() async throws -> [CollectionManga]
    func saveCollection(_ collection:CollectionManga) async throws
}

struct CollectionNetworkInteractor: CollectionRepository,NetworkInteractor {
    let session: URLSession
    
    func saveCollection(_ collection: CollectionManga) async throws {
        
    }
    
    var authToken: String?{
        UserAuthApi().getAuthToken()
    }
    func getCollections() async throws -> [CollectionManga] {
        let api = ApiMangaRequest(endpoint: .collection(.empty), method: .GET)
        var req = URLRequest.init(apiRequest: api)
        req!.setValue("Bearer \(String(describing: authToken))", forHTTPHeaderField: "Authorization")
        return try await getJson(request: req!, type: [CollectionManga].self)
    }
    init(session: URLSession = .shared) {
        self.session = session
    }
}

struct CollectionDataBaseInteractor: CollectionRepository {
    var authToken: String?
    let modelContext: ModelContext
    func getCollections() async throws -> [CollectionManga] {
        let descriptor = FetchDescriptor<CollectionDB>()
        return try modelContext.fetch(descriptor).map({$0.toPrimitive()})
    }
    
    func saveCollection(_ collection: CollectionManga) async throws {
        let collectionDB = try CollectionDB(id: collection.id, completeCollection: collection.completeCollection, readingVolume: collection.readingVolume, user: collection.user, manga: collection.manga.toValueObj(), volumesOwned: collection.volumesOwned)
        modelContext.insert(collectionDB)
        Task(priority: .background) {
            try await CollectionNetworkInteractor().saveCollection(collection)
        }
        try modelContext.save()
        
    }
}

struct CollectionMockInteractor: CollectionRepository,NetworkInteractor {
    var authToken: String?
    
    func getCollections() async throws -> [CollectionManga] {
        let url = Bundle.main.url(forResource: "collections", withExtension: "json")
        let jsonDecoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try await jsonDecoder.decode([CollectionManga].self, from: Data(contentsOf: url!))
    }
    
    func saveCollection(_ collection: CollectionManga) async throws {
        
    }
    
    let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
}
