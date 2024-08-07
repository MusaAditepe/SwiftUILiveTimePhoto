import SwiftUI

struct ContentView: View {
    
    @ObservedObject var store: PhotoStore = PhotoStore()
    
    var body: some View {
        NavigationView {
            List(store.photos, id: \.photoID) { photo in
                NavigationLink(destination: DetailView(photo: photo)) {
                    VStack(alignment: .leading) {
                        Text(photo.title)
                            .font(.headline)
                        AsyncImage(url: photo.remoteURL)
                            .frame(width: 300, height: 150)
                            .clipped()
                        Text(photo.dateTaken, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(photo.ownerName)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Interesting Photos")
            .onAppear {
                store.fetcInterestingPhotos()
            }
        }
    }
}

#Preview {
    ContentView()
}
