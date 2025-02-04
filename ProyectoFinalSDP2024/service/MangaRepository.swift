//
//  MangaRepository.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 29/12/24.
//
import Foundation
struct MangaRepository:NetworkInteractor{
    var session: URLSession
    
    func getMangas() async throws -> Mangas{
        let api = ApiMangaRequest.init(queryParams: ["page":"2","per":"20"], endpoint: .list(.mangas), method: .GET)
        let request = URLRequest(apiRequest: api)
        print(api.url)
        return try await getJson(request: request!, type: MangaServiceResponse.self).items
    }
        
}
