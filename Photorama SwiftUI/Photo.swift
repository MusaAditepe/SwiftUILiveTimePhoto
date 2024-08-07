//
//  Photo.swift
//  Photorama SwiftUI
//
//  Created by Musa Adıtepe on 5.08.2024.
//

import Foundation

class Photo: Codable, Identifiable {
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date
    let ownerName: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case remoteURL = "url_z"
        case photoID = "id"
        case dateTaken = "datetaken"
        case ownerName = "ownername"
    }
    
    init(title: String, remoteURL: URL, photoID: String, dateTaken: Date, ownerName: String) {
        self.title = title
        self.remoteURL = remoteURL
        self.photoID = photoID
        self.dateTaken = dateTaken
        self.ownerName = ownerName
    }
}
