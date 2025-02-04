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

struct MangaServiceResponse: Codable {
    let items: Mangas
    let metadata: Metadata
}

struct MangaDTO: Codable {
    let background: String
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
    let sypnosis, mainPicture: String
    let id: Int
    let themes: [Theme]
    let title: String
    public func toValueObj() -> Manga {
        return .init(id: id, startDate: startDate, endDate: endDate, chapters: chapters, mainPicture: mainPicture, background: background, volumes: volumes, title: title, status: status)
    }
}
struct Manga{
    let id:Int
    let startDate: Date
    let endDate: Date?
    let chapters: Int?
    let mainPicture: String
    let background: String
    let volumes: Int?
    let title: String
    let status:Status
    static let preview = Manga(id: 1, startDate: .now, endDate: nil, chapters: 120, mainPicture: "https://cdn.myanimelist.net/images/manga/1/157897l.jpg" , background: "Monster won the Grand Prize at the 3rd annual Tezuka Osamu Cultural Prize in 1999, as well as the 46th Shogakukan Manga Award in the General category in 2000. The series was published in English by VIZ Media under the VIZ Signature imprint from February 21, 2006 to December 16, 2008, and again in 2-in-1 omnibuses (subtitled The Perfect Edition) from July 15, 2014 to July 19, 2016. The manga was also published in Brazilian Portuguese by Panini Comics/Planet Manga from June 2012 to April 2015, in Polish by Hanami from March 2014 to February 2017, in Spain by Planeta Cómic from June 16, 2009 to September 21, 2010, and in Argentina by LARP Editores.", volumes: 10, title: "Monster", status: .currentlyPublishing)
}
// MARK: - Author
struct Author: Codable {
    let lastName, id: String
    let role: Role
    let firstName: String
}

enum Role: String, Codable {
    case art = "Art"
    case story = "Story"
    case both = "Story & Art"
}

// MARK: - DemographicElement
struct DemographicElement: Codable {
    let id: String
    let demographic: DemographicEnum
}

enum DemographicEnum: String, Codable {//
    case seinen = "Seinen"
    case shoujo = "Shoujo"
    case shounen = "Shounen"
    case josei = "Josei"
    case kids = "Kids"
}

struct Genre: Codable {
    let id, genre: String
}

enum Status: String, Codable {
    case currentlyPublishing = "currently_publishing"
    case finished = "finished"
    case hiatus = "on_hiatus"
}

struct Theme: Codable {
    let id, theme: String
}

// MARK: - Metadata
struct Metadata: Codable {
    let page, total, per: Int
}


typealias Mangas = [MangaDTO]
