//
//  Manga.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 9/12/24.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct UserId: Codable {
    let id: String
}

struct User:Codable{
    let email:String
    let password:String
    static let preview:User = .init(email: "jcfmunoz@icloud.com", password:"12345678")
}

struct CollectionManga: Codable,Identifiable {
    var completeCollection: Bool
    var readingVolume: Int
    let user: UserId
    let manga: MangaDTO
    var mangaVO:Manga{
        manga.toValueObj()
    }
    var volumesOwned: [Int]
    let id: String
    static let preview:CollectionManga = .init(completeCollection: false, readingVolume: 2, user: .init(id: "1"), manga: .preview, volumesOwned: [1,2,24,5,], id: "1")
}

struct MangaServiceResponse: Codable {
    let items: [MangaDTO]
    let metadata: Metadata
}

struct MangaDTO: Codable {
    let background: String?
    let startDate: Date
    let url: String
    let volumes: Int?
    let genres: [Genre]
    let titleEnglish: String?
    let titleJapanese: String
    let status: Status
    let score: Double
    let demographics: [DemographicElement]
    let authors: [Author]
    let endDate: Date?
    let chapters: Int?
    let sypnosis: String?
    let mainPicture:String
    let id: Int
    let themes: [Theme]
    let title: String
    static let preview = MangaDTO(
            background: "Monster won the Grand Prize at the 3rd annual Tezuka Osamu Cultural Prize in 1999...",
            startDate: Date(),
            url: "https://myanimelist.net/manga/1/Monster",
            volumes: 10,
            genres: [],
            titleEnglish: "Monster",
            titleJapanese: "モンスター",
            status: .finished,
            score: 8.9,
            demographics: [DemographicElement(id: "1",demographic: .seinen)],
            authors: [],
            endDate: nil,
            chapters: 162,
            sypnosis: """
            Kenzou Tenma, a renowned Japanese neurosurgeon working in post-war Germany, faces a difficult choice: 
            to operate on Johan Liebert, an orphan boy on the verge of death, or on the mayor of Düsseldorf...
            """,
            mainPicture: "\"https://cdn.myanimelist.net/images/manga/1/157897l.jpg\"",
            id: 1,
            themes: [],
            title: "Monster"
        )
    public func toValueObj() -> Manga {
        var picture = mainPicture
        picture.removeLast()
        picture.removeFirst()
        return .init(id: id, startDate: startDate, endDate: endDate, chapters: chapters, mainPicture: picture , background: background ?? "", volumes: volumes, title: title, status: status,authors:authors, sypnosis: sypnosis,genres: genres,demographics: demographics,themes: themes, score: score)
        
    }
}


struct Manga:Identifiable,Codable{
    let id:Int
    let startDate: Date
    let endDate: Date?
    let chapters: Int?
    let mainPicture: String
    let background: String
    let volumes: Int?
    let title: String
    let status:Status
    let authors:[Author]
    let sypnosis: String?
    let genres: [Genre]
    let demographics: [DemographicElement]
    let themes: [Theme]
    let score: Double
    static let preview = Manga(id: 1, startDate: .now, endDate: nil, chapters: 120, mainPicture: "https://cdn.myanimelist.net/images/manga/1/157897l.jpg" , background: "Monster won the Grand Prize at the 3rd annual Tezuka Osamu Cultural Prize in 1999, as well as the 46th Shogakukan Manga Award in the General category in 2000. The series was published in English by VIZ Media under the VIZ Signature imprint from February 21, 2006 to December 16, 2008, and again in 2-in-1 omnibuses (subtitled The Perfect Edition) from July 15, 2014 to July 19, 2016. The manga was also published in Brazilian Portuguese by Panini Comics/Planet Manga from June 2012 to April 2015, in Polish by Hanami from March 2014 to February 2017, in Spain by Planeta Cómic from June 16, 2009 to September 21, 2010, and in Argentina by LARP Editores.", volumes: 10, title: "Monster", status: .currentlyPublishing,authors: [],sypnosis: "Kenzou Tenma, a renowned Japanese neurosurgeon working in post-war Germany, faces a difficult choice: to operate on Johan Liebert, an orphan boy on the verge of death, or on the mayor of Düsseldorf. In the end, Tenma decides to gamble his reputation by saving Johan, effectively leaving the mayor for dead.\n\nAs a consequence of his actions, hospital director Heinemann strips Tenma of his position, and Heinemann's daughter Eva breaks off their engagement. Disgraced and shunned by his colleagues, Tenma loses all hope of a successful career—that is, until the mysterious killing of Heinemann gives him another chance.\n\nNine years later, Tenma is the head of the surgical department and close to becoming the director himself. Although all seems well for him at first, he soon becomes entangled in a chain of gruesome murders that have taken place throughout Germany. The culprit is a monster—the same one that Tenma saved on that fateful day nine years ago.\n\n[Written by MAL Rewrite]", genres: [],demographics: [],themes: [], score: 12.5)
    
    func toValueObj()->MangaDTO{
        .init(background: background, startDate: startDate, url: "", volumes: volumes, genres: genres, titleEnglish: "", titleJapanese: "", status: status, score: score, demographics: demographics, authors: authors, endDate: endDate, chapters: chapters, sypnosis: sypnosis, mainPicture: mainPicture, id: id, themes: themes, title: title)
    }
}
// MARK: - Author
struct Author: Codable,Identifiable,Hashable,Equatable {
    let lastName, id: String
    let role: Role
    let firstName: String
    var fullName:String{
        "\(firstName) \(lastName)"
    }
}

enum Role: String, Codable {
    case art = "Art"
    case story = "Story"
    case both = "Story & Art"
}

// MARK: - DemographicElement
struct DemographicElement: Codable ,Hashable{
    let id: String
    let demographic: DemographicEnum
}
enum DemographicEnum: String, Codable ,CaseIterable{
    case seinen = "Seinen"
    case shoujo = "Shoujo"
    case shounen = "Shounen"
    case josei = "Josei"
    case kids = "Kids"
}

struct Genre: Codable,Hashable {
    let id, genre: String
}

enum Status: String, Codable {
    case currentlyPublishing = "currently_publishing"
    case finished = "finished"
    case hiatus = "on_hiatus"
}

struct Theme: Codable ,Hashable{
    let id, theme: String
}

// MARK: - Metadata
struct Metadata: Codable {
    let page, total, per: Int
}


typealias Mangas = [Manga]
