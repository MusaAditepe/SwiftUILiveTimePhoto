//
//  FlickrAPI.swift
//  Photorama SwiftUI
//
//  Created by Musa Adıtepe on 5.08.2024.
//
/* API'ın tam hali : https://www.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=6568b09ea15905fdd1e848df0b005729&extras=date_taken,owner_name,url_z&format=json&nojsoncallback=1
*/
import Foundation
    
enum Endpoint: String {
    case interestingPhotos = "flickr.interestingness.getList"
}

struct FlickrResponse: Codable {
    let photosInfo: FlickrPhotosResponse
    
    enum CodingKeys: String, CodingKey {
        case photosInfo = "photos"
    }
}

struct FlickrPhotosResponse: Codable {
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case photos = "photo"
    }
}

struct FlickrAPI {
    private static let baseURLString = "https://www.flickr.com/services/rest/"
    private static let apiKey = "6568b09ea15905fdd1e848df0b005729"
    
    static private func flickrURL(endpoint: Endpoint, parameters: [String: String]?) -> URL {
        var components = URLComponents(string: baseURLString)!
        var queryItems: [URLQueryItem] = []
        
        let baseParams = [
            "format": "json",
            "nojsoncallback": "1",
            "api_key": apiKey,
            "method": endpoint.rawValue
        ]
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        return components.url!
    }
    
    static var interestingPhotosURL: URL {
        return flickrURL(endpoint: .interestingPhotos, parameters: ["extras": "url_z,date_taken,owner_name"])
    }
    
    static func photos(fromJSON data: Data) -> Result<[Photo], Error> {
        do {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let flickrResponse = try decoder.decode(FlickrResponse.self, from: data)
            return .success(flickrResponse.photosInfo.photos)
        } catch {
            return .failure(error)
        }
    }
}
