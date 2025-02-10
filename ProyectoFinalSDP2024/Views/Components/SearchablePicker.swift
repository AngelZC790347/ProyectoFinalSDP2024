//
//  SearchablePicker.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 9/02/25.
//

import SwiftUI
struct AuthorSelectionView: View {
    @Binding var selectedAuthor: Author?
    @State private var searchText = ""
    let authors: [Author]

    var filteredAuthors: [Author] {
        searchText.isEmpty ? authors : authors.filter { $0.fullName.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        VStack {
            TextField("Escribe un autor...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding().tint(.secondarySB)

            ScrollView {
                LazyVStack {
                    ForEach(filteredAuthors, id: \.self) { author in
                        Button {
                            selectedAuthor = author
                        } label: {
                            HStack {
                                Text(author.fullName).foregroundStyle(.secondarySB)
                                    .padding()
                                Spacer()
                                if selectedAuthor == author {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.secondarySB)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.onprimary)
                            .cornerRadius(8)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle("Buscar Autor")
    }
}
struct AuthorPickerView: View {
    @Binding var selectedAuthor: Author?
    @FocusState private var isTextFieldFocused: Bool
    @State var authorsVM: AuthorsViewModel
    
    var filteredAuthors: [Author] {
        authorsVM.searchString.isEmpty ? authorsVM.authors : authorsVM.authors.filter { "\($0.firstName) \($0.lastName)".localizedCaseInsensitiveContains(authorsVM.searchString) }
    }
    
    var body: some View {
        NavigationStack {            
                NavigationLink(destination: AuthorSelectionView(selectedAuthor: $selectedAuthor, authors: authorsVM.authors)) {
                    HStack {
                        Text("Autor").foregroundStyle(.secondarySB)
                        Spacer()
                        Text(selectedAuthor?.fullName ?? "No Selection").foregroundStyle(.secondarySB).bold()
                        
                    }.padding(10).background(.ontertiary).cornerRadius(10)
                }
        }
    }
}
#Preview {
    AuthorPickerView(selectedAuthor: .constant(nil),authorsVM: AuthorsViewModel(repository: AuthorMockIntereactor()))
}
