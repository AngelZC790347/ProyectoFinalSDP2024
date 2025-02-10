//
//  NetworkInteractor.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 9/12/24.
//
import Foundation
public protocol NetworkInteractor {
    var session: URLSession { get }
}

extension NetworkInteractor {
    func getJson<JSON>(request:URLRequest, type:JSON.Type) async throws(NetworkError) -> JSON where JSON:Codable{
        let (data,response) = try await session.getData(for: request)
        guard  response.statusCode == 200 else {
            throw .status(response.statusCode)
        }
        do{
            let jsonDecoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
            return try jsonDecoder.decode(type, from: data)
        }catch{
            throw .json(error)
        }
    }
    public func getStatusCode(request: URLRequest) async throws->Int {
        let (_, response) = try await session.getData(for: request)
        return response.statusCode
    }
}
