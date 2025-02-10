//
//  Endpoit.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 9/12/24.
//
import Foundation
enum UserEndpoint:String{
    case empty = ""
    case login = "login"
    case renew = "renew"
}

enum CollectionMangeEndpoint:CustomStringConvertible{
    var description: String{
        return switch self{
        case .empty:"manga"
        case .id(let id):"manga/\(id)"
        }
    }
    case empty
    case id(Int)
}
enum SearchAnyEndpoint:CustomStringConvertible{
    case manga(Int?)
    case mangasBeginsWith(String)
    case mangasContains(String)
    case author(String)
    var description: String{
        return switch self{
        case .manga(let id):
            "manga" + (id != nil ? "/\(String(describing: id))" :"")
        case .mangasBeginsWith(let beginWith):
            "mangasBeginsWith/\(beginWith)"
        case .mangasContains(let contains):
            "mangasContains/\(contains)"
        case .author(let author):
            "author/\(author)"
        }
    }
    
}
enum ListByAnyEndpoint:CustomStringConvertible{
    case authors(String)
    case demographics(String)
    case genres(String)
    case themes(String)
    var description: String{
        return switch self{
        case .authors(let authorId):
            "mangaByAuthor/\(authorId)"
        case .demographics(let demo):
            "mangaByDemographic/\(demo)"
        case .genres(let genre):
            "mangaByGenre/\(genre)"
        case .themes(let theme):
            "mangaByTheme/\(theme)"
        }
    }
    
    
}

enum ListEndpoint:String{
    case mangas = "mangas"
    case bestMangas = "bestMangas"
    case authors = "authors"
    case demographics = "demographics"
    case genres = "genres"
    case themes = "themes"
}

enum RequestMethod:String{
    case GET = "GET"
    case POST = "POST"
    case DElETE = "DELETE"
}
struct ApiMangaRequest{
    static let ApiToken = "sLGH38NhEJ0_anlIWwhsz1-LarClEohiAHQqayF0FY"
    var url: String{
        var uri = "\(ApiMangaRequest.uri)\(endpoint)"
        if let queryParams = queryParams{
            uri += ("?" + queryParams.map({$0.key + "=\($0.value)"}).joined(separator: "&"))
        }
        return uri
    }
    static let uri = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com"
    var queryParams : [String:String]?
    var body:[String:Any]?
    var endpoint : Endpoint
    var method:RequestMethod
    enum Endpoint:CustomStringConvertible{
        case list(ListEndpoint)
        case listByAny(ListByAnyEndpoint)
        case search(SearchAnyEndpoint)
        case user(UserEndpoint)
        case collection(CollectionMangeEndpoint)
        var description: String{
            return switch self{
            case .list(let endpoint):
                "/list/\(endpoint)"
            case .listByAny(let listEndpoitn):
                "/list/\(listEndpoitn)"
            case .search(let searchEndpoint):
                "/search/\(searchEndpoint)"
            case .user(let userEndpoint):
                "/user/\(userEndpoint)"
            case .collection(let collectionEndpoint):
                "/collection/\(collectionEndpoint)"
            }
        }
    }
}

extension URLRequest{
    init? (apiRequest:ApiMangaRequest){
        guard let url = URL(string: apiRequest.url) else{
            return nil
        }
        
        self.init(url: url,timeoutInterval: 60)
        self.httpMethod = apiRequest.method.rawValue
        if case .user(_) = apiRequest.endpoint , case .collection = apiRequest.endpoint {
            self.setValue(ApiMangaRequest.ApiToken, forHTTPHeaderField: "App-Token")
        }
        if let body = apiRequest.body {
           do {
               self.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
               self.setValue("application/json", forHTTPHeaderField: "Content-Type")
           } catch {
               print("Error serializing body to JSON: \(error)")
               self.httpBody = nil
           }
        }
    }
}
