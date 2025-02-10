//
//  SBCard.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 22/01/25.
//

import SwiftUI
struct SBCard:View{
    var manga:Manga
    var body: some View {
            ZStack {
                AsyncImage(url: URL(string: manga.mainPicture)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Text("Loadding")
                }
                .frame(width: 200, height: 300)
                .clipped()
                LinearGradient(
                    colors: [Color.black.opacity(0.8), Color.clear],
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(width: 200, height: 300)
                VStack {
                    Spacer()
                    Text(manga.title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical,8)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(8)
                        .padding(.bottom, 8)
                }
                .frame(width: 200, height: 300)
            }
            .frame(width: 200, height: 300)
            .cornerRadius(12)
            .shadow(radius: 5)           
        }
}
#Preview {
    SBCard(manga: .preview).frame(width: 300,height: 400)
}
