//
//  SearchMangaView.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 8/02/25.
//

import SwiftUI

struct SearchMangaView: View {
    let columns = [
    GridItem(.flexible(), spacing: 80),GridItem(.flexible(), spacing: 80)]
    @State var mangaVM:MangasSearchViewModel
    var authorVM : AuthorsViewModel = AuthorsViewModel(repository: AuthorMockIntereactor())
    var body: some View {
        NavigationStack{
            VStack{
                HStack{                    
                    TextField("Buscar", text: $mangaVM.searchString).textFieldStyle(.roundedBorder).tint(.primarySB)
                    Button {
                        Task {
                            await mangaVM.searchMangas()
                        }
                    } label: {
                        Image(systemName: "magnifyingglass").foregroundStyle(.secondarySB)
                    }.buttonStyle(.bordered).buttonBorderShape(.capsule).tint(.secondarySB)
                    
                }.padding(.vertical)
                
                VStack{
                    Label("Filtros", systemImage: "line.3.horizontal.decrease").foregroundStyle(.secondarySB).bold().font(.title3)
                    AuthorPickerView(selectedAuthor: $mangaVM.selectedAuthor, authorsVM: authorVM)
                    Picker("Tema", selection: $mangaVM.selectedTheme) {
                        Text("Ninguno").tag(nil as Theme?)
                        ForEach(authorVM.themes, id: \.self) { theme in
                            Text(theme.theme)
                        }
                    }.padding()
                    .pickerStyle(.navigationLink)
                    .tint(.secondarySB)
                    Picker("Genero", selection: $mangaVM.selectedGenre) {
                        Text("Ninguno").tag(nil as Genre?)
                        ForEach(authorVM.genres, id: \.self) { genre in
                            Text(genre.genre)
                        }
                    }.padding()
                    .pickerStyle(.navigationLink)
                    .tint(.secondarySB)
                    Picker("Demografía", selection: $mangaVM.selectedDemo) {
                        Text("Ninguno").tag(nil as DemographicEnum?)
                        ForEach(DemographicEnum.allCases, id: \.self) { demo in
                            Text(demo.rawValue).tag(demo as DemographicEnum?)
                        }
                    }.padding()
                    .pickerStyle(.navigationLink)
                    .tint(.secondarySB)
                }
            }.padding(.vertical)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach($mangaVM.showedMangas) { manga in
                        SBCard(manga: manga.wrappedValue)
                    }
                }
                .padding()
            }
            Spacer()
        }.navigationTitle("Explorar").padding()
            .navigationTitle("Buscar")
        }
    }


#Preview {
    SearchMangaView(mangaVM: MangasSearchViewModel(repository: MangeMockInteractor()))
}
