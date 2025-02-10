//
//  MangaDetailView.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 9/02/25.
//

import SwiftUI

import SwiftUI

struct MangaDetailView: View {
    @State var manga: Manga
    @State private var isAdded = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Imagen del Manga
                AsyncImage(url: URL(string: manga.mainPicture)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(maxWidth: 250, maxHeight: 350)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // Título
                Text(manga.title)
                    .font(.title)
                    .bold()
                    .foregroundColor(.primarySB)
                
                // Estado del Manga
                Text(manga.status.rawValue.replacing("_", with: " ", maxReplacements: .max).capitalized)
                    .font(.subheadline)
                    .foregroundColor(.primarySB)
                
                // Fechas de Publicación
                HStack {
                    Text("📅 Inicio: \(formattedDate(manga.startDate))")
                    if let endDate = manga.endDate {
                        Text(" | Fin: \(formattedDate(endDate))")
                    }
                }
                .font(.caption)
                .foregroundColor(.gray)
                
                // Sección de Sinopsis
                if let synopsis = manga.sypnosis {
                    SectionTitle(title: "Sinopsis")
                    Text(synopsis)
                        .font(.body)
                        .foregroundColor(.gray)
                        .lineLimit(nil)
                }
                
                // Sección de Autores
                if !manga.authors.isEmpty {
                    SectionTitle(title: "Autores")
                    ForEach(manga.authors, id: \.self) { author in
                        Text(author.fullName)
                    }
                }
                
                // Sección de Géneros
                if !manga.genres.isEmpty {
                    SectionTitle(title: "Géneros")
                    GenreListView(genres: manga.genres)
                }
                
                // Sección de Demografía
                if !manga.demographics.isEmpty {
                    SectionTitle(title: "Demografía")
                    GenreListView(genres: manga.demographics.map { Genre(id: UUID().uuidString, genre: $0.demographic.rawValue) })
                }
                
                // Sección de Temas
                if !manga.themes.isEmpty {
                    SectionTitle(title: "Temas")
                    ThemesListView(thenes: manga.themes)
                }
                
                // Botón para agregar a la colección
                Button(action: {
                    withAnimation {
                        isAdded.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: isAdded ? "checkmark.circle.fill" : "plus.circle")
                            .font(.title2)
                            .foregroundColor(isAdded ? .tertiary : .secondaryfixed)
                        Text(isAdded ? "Agregado a Colección" : "Agregar a Colección")
                            .fontWeight(.semibold)
                            .foregroundColor(isAdded ? .tertiary : .secondaryfixed)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isAdded ? .tertiarycontainer : Color.onsecondaryfixedvariant)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("Detalles del Manga")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Formatear fecha
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

// Vista para mostrar subtítulos de secciones
struct SectionTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.primarySB)
            .padding(.top, 10)
    }
}

// Vista para listar géneros, temas o demografías
struct GenreListView: View {
    let genres: [Genre]
    
    var body: some View {
        HStack {
            ForEach(genres, id: \.self) { genre in
                Text(genre.genre)
                    .padding(6)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
            }
        }
    }
}
struct ThemesListView: View {
    let thenes: [Theme]
    
    var body: some View {
        HStack {
            ForEach(thenes, id: \.self) { theme in
                Text(theme.theme)
                    .padding(6)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
            }
        }
    }
}
#Preview {
    MangaDetailView(manga: .preview)
}
