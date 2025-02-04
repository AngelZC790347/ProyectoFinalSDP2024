//
//  ProyectoFinalSDP2024Tests.swift
//  ProyectoFinalSDP2024Tests
//
//  Created by Angel Zuñiga on 29/12/24.
//

import Testing
@testable import ProyectoFinalSDP2024


struct ProyectoFinalSDP2024Tests {

    @Test func example() async throws {
        let request = ApiMangaRequest(endpoint: .list(.mangas), method: .GET)
        #expect(request.url == "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/mangas")
        let repository = MangaRepository(session: .shared)
        #expect(try await repository.getMangas().count == 20)
    }
    @Test func testLogin() async throws {
        
    }

}
