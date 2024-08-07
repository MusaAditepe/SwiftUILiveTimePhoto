import SwiftUI

struct DetailView: View {
    let photo: Photo
    
    var body: some View {
        VStack (alignment: .leading){
            AsyncImage(url: photo.remoteURL)
                .frame(width: 400, height: 400)
                .clipped()
            
            Text(photo.title)
                .font(.largeTitle)
                .padding()
            
            Text("Taken on: \(photo.dateTaken, style: .date)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
            
            Text("Taken by: \(photo.ownerName)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
              
            Spacer()
        }
        .navigationTitle("Photo Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(photo: Photo(title: "Example", remoteURL: URL(string: "https://example.com")!, photoID: "1", dateTaken: Date(), ownerName: ""))
}


