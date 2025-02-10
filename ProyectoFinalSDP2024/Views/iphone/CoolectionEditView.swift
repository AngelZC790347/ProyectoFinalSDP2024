import SwiftUI

struct CollectionEditView: View {
    @Binding var collection: CollectionManga
    @State var collectionRepository: CollectionRepository
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                CollectionCard(collection: collection).frame(maxWidth: .infinity)
                Text("Editar Colección")
                    .foregroundStyle(.primarySB)
                    .font(.title)
                    .bold()
                HStack {
                    Text("Colección completa")
                    Spacer()
                    Toggle("", isOn: $collection.completeCollection)
                        .labelsHidden()
                }
                HStack(spacing: 8) {
                    Text("Volumen en lectura actual")
                        .bold()
                    Picker("Volumen ", selection: $collection.readingVolume) {
                        ForEach(collection.volumesOwned,id: \.self) { vol in
                            Text("\(vol)").tag(vol)
                        }
                    }.pickerStyle(.menu).tint(.primarySB)
                    
                    
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Volúmenes poseídos")
                        .bold()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(collection.volumesOwned, id: \.self) { volume in
                                Text("Vol. \(volume)")
                                    .padding(8)
                                    .background(Color.secondary.opacity(0.2))
                                    .cornerRadius(8)
                            }
                            
                            Button(action: addVolume) {
                                Image(systemName: "plus")
                                    .padding(9)
                                    .background(.primarycontainer.opacity(0.2))
                                    .cornerRadius(8)
                                    .foregroundStyle(.primarySB)
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .toolbar() {
                ToolbarItem() {
                    Button("Save") {
                        Task {
                            try await collectionRepository.saveCollection(collection)
                            
                        }
                        dismiss()
                    }.tint(.primarySB)
                }
            }
        }
    }
    
    private func addVolume() {
        guard let maxVolume = collection.mangaVO.volumes else { return }
        let newVolume = (collection.volumesOwned.max() ?? 0) + 1
        
        if newVolume <= maxVolume {
            collection.volumesOwned.append(newVolume)
        }
    }
}

#Preview {
    CollectionEditView(collection: .constant(.preview), collectionRepository: CollectionMockInteractor())
}
