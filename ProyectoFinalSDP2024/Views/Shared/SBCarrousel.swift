//
//  SBCard.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 22/01/25.
//

import SwiftUI

struct ColorScheme {
    let titleColor:Color
    let bgColor:Color
}


struct SBCarrousel: View,Identifiable {
    var id:UUID {
         UUID()
    }
    
    var title:String
    var icon:Image?
    let columns = [GridItem(.fixed(300), alignment: .leading)]
    let colorScheme:ColorScheme
    var mangas:[Manga]
    var body: some View {
        VStack(alignment:.leading,spacing: 0){
            HStack(alignment: .bottom){
                Text(title).foregroundStyle(colorScheme.titleColor)
                icon?.foregroundStyle(colorScheme.titleColor)
            }.padding(.top)
            Divider().background(colorScheme.titleColor).frame(height: 1).padding(.vertical,20)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: columns, spacing: 10) {
                    ForEach(mangas, id: \.id) { manga in
                        SBCard(manga: manga).frame(width: 200, height: 300).scaleEffect(0.95)                          
                    }
                }
            }.padding(.bottom)
        }.padding()
            .background(colorScheme.bgColor)
            .cornerRadius(12)
            .shadow(radius: 5)
        
    }
}

#Preview {
    SBCarrousel(title: "Most Downloaded", colorScheme: .init(titleColor: .primarySB, bgColor: .primarycontainer), mangas: [.preview,.preview,.preview,.preview])
}
