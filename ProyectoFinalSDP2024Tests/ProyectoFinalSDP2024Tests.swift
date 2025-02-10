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
        let repository = MangaApiInteractor(session: .shared)
        #expect(try await repository.getMangas(page: 1).count == 20)
    }
    @Test func testLogin() async throws {
        let service = AuthService()
        await #expect(throws: AutError.invalidCrendetianls, performing: {try await service.login(email: "angel1200z@gmail.com", password: "1234")})
    }
    @Test func testCollection() async throws {
        let service = CollectionMockInteractor()
        #expect(try await service.getCollections().count == 8)
    }

}
