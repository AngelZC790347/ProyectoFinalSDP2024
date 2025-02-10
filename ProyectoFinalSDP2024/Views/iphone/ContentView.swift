//
//  ContentView.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 7/12/24.
//

import SwiftUI





struct ContentView: View {
    @State var mangasViewModel : MangasViewModel
    init(mangasViewModel:MangasViewModel) {
        self.mangasViewModel = mangasViewModel
        let primaryColor = UIColor(red: 0.27, green: 0.06, blue: 0.07, alpha: 1.0)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: primaryColor]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor:primaryColor]        

    }
    var body: some View {
        let listSections = [
            SBCarrousel(title: "Te Gustaria", icon:Image(systemName: "heart.fill"), colorScheme: .init(titleColor: .primarySB, bgColor: .primarycontainer), mangas:mangasViewModel.mostDownloaded) ,
                    SBCarrousel(title: "Best By Author", icon:Image(systemName: "star.fill"), colorScheme: .init(titleColor: .secondarySB, bgColor: .secondarycontainer), mangas:mangasViewModel.mostDownloaded) ]
            NavigationStack {
                ScrollView {
                    VStack(spacing:60){
                        ForEach(listSections) { section in
                            section
                        }
                    }.padding(.top,50).padding()
                        .navigationTitle("AnimeSB")
                    .toolbar {
                        ToolbarItem {
                            NavigationLink {
                                Text("Profile")
                            } label: {
                                Image(systemName: "person.crop.circle.fill")
                                .foregroundStyle(.primarySB).padding()
                            }

                        }
                    }
                }
            }
            .tint(.primarySB)
        }
}

#Preview {
        
        TabView() {
            Tab("Inicio", systemImage: "house") {
                ContentView(mangasViewModel: MangasViewModel(repository: MangeMockInteractor()))
            }
            

            Tab("Mi Collecion", systemImage: "books.vertical.fill") {
                MiCollecion(collectionVM: CollectionViewModel(repository: CollectionMockInteractor()))
            }
            
            Tab("Buscar", systemImage: "magnifyingglass") {
                SearchMangaView(mangaVM: MangasSearchViewModel(repository: MangeMockInteractor()))
            }
        }.tint(.primarySB)
        
}
