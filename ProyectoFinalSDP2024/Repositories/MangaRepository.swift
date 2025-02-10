//
//  MangaRepository.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 29/12/24.
//
import Foundation
import SwiftData
protocol MangaRepository{
    func getMangas(page:Int) async throws -> Mangas
    func getMostPouplarMangas(page:Int) async throws -> Mangas
    func searchMangaByQueryString(query:String,page:Int) async throws -> Mangas
    func getMangaByID(id:Int) async throws->Manga?
}

struct MangaApiInteractor:MangaRepository,NetworkInteractor{
    func getMangaByID(id: Int) async throws -> Manga? {
        let api = ApiMangaRequest(endpoint: .search(.manga(id)), method: .GET)
        let request = URLRequest(apiRequest: api)
        return try await getJson(request: request!, type: MangaDTO.self).toValueObj()
    }
    
    func searchMangaByQueryString(query: String, page: Int) async throws -> Mangas {
        let api = ApiMangaRequest(queryParams: ["page":"\(page)","per":"20"],endpoint: .search(.mangasContains(query)), method: .GET)
        let request = URLRequest(apiRequest: api)
        return try await getJson(request: request!, type: MangaServiceResponse.self).items.map({$0.toValueObj()})
    }
    
    func getMostPouplarMangas(page:Int) async throws -> Mangas {
        let api = ApiMangaRequest.init(queryParams: ["page":"\(page)","per":"20"], endpoint: .list(.bestMangas), method: .GET)
        let request = URLRequest(apiRequest: api)
        return try await getJson(request: request!, type: MangaServiceResponse.self).items.map({$0.toValueObj()})
    }
    func getMangas(page:Int) async throws -> Mangas{
        let api = ApiMangaRequest.init(queryParams: ["page":"\(page)","per":"20"], endpoint: .list(.mangas), method: .GET)
        let request = URLRequest(apiRequest: api)
        return try await getJson(request: request!, type: MangaServiceResponse.self).items.map({$0.toValueObj()})
    }
    let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
        
}

struct MangeMockInteractor:MangaRepository{
    func getMangaByID(id: Int) async throws -> Manga? {
        return try await getMangas().filter({$0.id == id}).first
    }
    
    func searchMangaByQueryString(query: String, page: Int) async throws -> Mangas {
        return try await getMangas().filter({$0.title.contains(query)})
    }
    
    func getMostPouplarMangas(page:Int = 0) async throws -> Mangas {
        try await getMangas()
    }
    
    
    func getJSON<JSON>(url: URL, type: JSON.Type) throws -> JSON where JSON: Decodable {
        let data = try Data(contentsOf: url)        
        let jsonDecoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try jsonDecoder.decode(type, from: data)
    }
    func getMangas(page:Int = 0) async throws -> Mangas {
        return try getJSON(url: Bundle.main.url(forResource: "mangas", withExtension: "json")!, type:MangaServiceResponse.self).items.map({$0.toValueObj()})
    }
        
}


