//
//  CollectionCard.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 8/02/25.
//


import SwiftUI

struct CollectionCard:View{
    var collection:CollectionManga
    var body: some View{
        VStack(spacing:20){
            ZStack {
                Ellipse()
                .fill(Color.black.opacity(0.2))
                .frame(width: 150, height: 20)
                .offset(y: 110)
                .blur(radius: 8)
                AsyncImage(url: URL(string: collection.mangaVO.mainPicture)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 200)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(width: 150, height: 200)
                }
            }
            VStack{
                Text(collection.mangaVO.title).font(.title3)
                .lineLimit(2)
                .frame(height: 50)
                Text("Volumen Actual: \(collection.readingVolume)").foregroundColor(.primary).font(.caption)
            }
            
        }.padding()
    }
}
