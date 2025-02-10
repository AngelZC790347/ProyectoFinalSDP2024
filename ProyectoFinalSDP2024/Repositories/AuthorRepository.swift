//
//  AuthorRepository.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 9/02/25.
//
import Foundation
protocol AuthorRepository{
    func getAuthors() async throws->[Author]
    func getThemes() async throws -> [Theme]
    func getGenres() async throws ->[Genre]
}

struct AuthorMockIntereactor:AuthorRepository,NetworkInteractor{
    func getThemes() async throws -> [Theme] {
        let mock = [
            "Gore",
            "Military",
            "Mythology",
            "Psychological",
            "Historical",
            "Samurai",
            "Romantic Subtext",
            "School",
            "Adult Cast",
            "Parody",
            "Super Power",
            "Team Sports",
            "Delinquents",
            "Workplace",
            "Survival",
            "Childcare",
            "Iyashikei",
            "Reincarnation",
            "Showbiz",
            "Anthropomorphic",
            "Love Polygon",
            "Music",
            "Mecha",
            "Combat Sports",
            "Isekai",
            "Gag Humor",
            "Crossdressing",
            "Reverse Harem",
            "Martial Arts",
            "Visual Arts",
            "Harem",
            "Otaku Culture",
            "Time Travel",
            "Video Game",
            "Strategy Game",
            "Vampire",
            "Mahou Shoujo",
            "High Stakes Game",
            "CGDCT",
            "Organized Crime",
            "Detective",
            "Performing Arts",
            "Medical",
            "Space",
            "Memoir",
            "Villainess",
            "Racing",
            "Pets",
            "Magical Sex Shift",
            "Educational",
            "Idols (Female)",
            "Idols (Male)"
        ]
        
        return mock.map({Theme(id: "\(mock.firstIndex(of: $0))", theme: $0)})
    }
    
    func getGenres() async throws -> [Genre] {
        let mock =  [
            "Action",
            "Adventure",
            "Award Winning",
            "Drama",
            "Fantasy",
            "Horror",
            "Supernatural",
            "Mystery",
            "Slice of Life",
            "Comedy",
            "Sci-Fi",
            "Suspense",
            "Sports",
            "Ecchi",
            "Romance",
            "Girls Love",
            "Boys Love",
            "Gourmet",
            "Erotica",
            "Hentai",
            "Avant Garde"
        ]
        return mock.map({Genre(id: "\(mock.firstIndex(of: $0))", genre: $0)})
    }
    
    var session: URLSession{
        return .shared
    }
    func getAuthors() async throws -> [Author] {
        let url = Bundle.main.url(forResource: "authors", withExtension: "json")
        return try JSONDecoder().decode([Author].self, from: Data(contentsOf: url!))
    }
}
