//
//  AuthService.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 6/02/25.
//
import Foundation

enum AutError:String,Error,Equatable{
    case invalidCrendetianls = "Invalid Credentials"
    case credntialCodingError = "Error al codificar credenciales"
    case badRequestError = "Mal envio de request"
}

class AuthService:NetworkInteractor{
    var session: URLSession{
        .shared
    }
    func register(email:String,password:String) async throws ->String{
        let request = URLRequest(apiRequest: ApiMangaRequest(endpoint: .user(.empty), method: .POST))
        if try await getStatusCode(request: request!) == 400{
            throw AutError.badRequestError
        }
        return try await login(email: email, password: password)
    }
    func login(email:String,password:String) async throws ->String{
        let url = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/users/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let credentials = "\(email):\(password)"
            guard let credentialData = credentials.data(using: .utf8) else {
                throw AutError.credntialCodingError
            }
            
        let base64Credentials = credentialData.base64EncodedString()
        request.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        let (data,response) = try await session.getData(for: request)
        if response.statusCode == 401{
            throw AutError.invalidCrendetianls
        }
        print(String(data: data, encoding: .utf8)!)
        return String(data: data, encoding: .utf8)!
    }
    func sigIn(email:String,password:String) async throws ->Bool{
        let url = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(User(email: email, password: password))
        let (_,response) = try await session.getData(for: request)
        return response.statusCode == 200
    }
    
}
