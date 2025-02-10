//
//  ProyectoFinalSDP2024App.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 7/12/24.
//

import SwiftUI

import SwiftData


extension String{
    func isValidEmail() -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
}

enum UserState{
    case logued
    case loading
    case unaunthenticated
}


@Observable
class AppState{
    let isIpad:Bool = (UIDevice.current.userInterfaceIdiom == .pad)
    var authInteractor:UserAuthInteractor
    var state:UserState
    var errorMsg = ""
    init(authInteractor: UserAuthInteractor = UserAuthApi()) {
        self.authInteractor = authInteractor
        self.state = (authInteractor.isAuthrnticated() ? .logued : .unaunthenticated)
    }
    func register(email:String,password:String)->Void{
        if email.isEmpty || password.isEmpty{
            errorMsg="All fields are required"
            return
        }
        if !email.isValidEmail(){
            errorMsg = "Invalid email"
            return
        }
        self.state = .loading
        self.authInteractor
    }
    func login(email:String,password:String) -> Void {
        if email.isEmpty || password.isEmpty{
            errorMsg="All fields are required"
            return
        }
        if !email.isValidEmail(){
            errorMsg = "Invalid email"
            return
        }        
        self.state = .loading
        self.authInteractor.login(emial: email, password: password) { res in
          switch res{
          case .success(()):
              self.state = .logued
              break
          case .failure(let error ):
              self.errorMsg = "\(error)"
              self.state = .unaunthenticated
              
          }
        }
      }
      func logOut(){
          print("log out")
          self.authInteractor.logout()
          self.state = .unaunthenticated
      }
}


@main
struct ProyectoFinalSDP2024App: App {
    @State var env = AppState()
    @State private var mangasVm = MangasViewModel(repository: MangeMockInteractor())
    @State private var collectionVieModel = CollectionViewModel(repository: CollectionNetworkInteractor())
    var body: some Scene {
        WindowGroup {
            switch env.state{
            case.unaunthenticated:
                LoginView().environment(env)
            case .loading:
                Text("Loading *****")
            case .logued:
                TabView() {
                    Tab("Inicio", systemImage: "house") {
                        if env.isIpad {
                            ContentViewIpad()
                        }else{
                            ContentView(mangasViewModel: MangasViewModel(repository: MangeMockInteractor()))
                        }
                    }
                    
                    Tab("Mi Collecion", systemImage: "books.vertical.fill") {
                        MiCollecion(collectionVM: collectionVieModel)
                    }
                    
                    Tab("Buscar", systemImage: "magnifyingglass") {
                        SearchMangaView(mangaVM: MangasSearchViewModel())
                    }
                }.tint(.primarySB).environment(mangasVm)
                
            }
                        
        }.modelContainer(for: CollectionDB.self) { result in
            guard case .success(let container) = result else {
                return
            }
            let mangaQuery = FetchDescriptor<CollectionDB>()
            if(try? container.mainContext.fetchCount(mangaQuery) == 0) ?? false{
                Task{
                    try await CollectionDBLoader(repository: CollectionNetworkInteractor()).loadData(context: container.mainContext)
                }
            }
        }
    }
}
