//
//  PhotoStore.swift
//  Photorama SwiftUI
//
//  Created by Musa Adıtepe on 5.08.2024.
//

import Foundation

class PhotoStore: ObservableObject{
    
    private  let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    @Published var photos: [Photo] = []
    @Published var error:  Error?
    
    func fetcInterestingPhotos(){
        
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url) 
        let task = session.dataTask(with: request) { data, response, error in
            let result = self.processPhotosRequest(data: data, error: error)
            switch result {
            case let .success(photos):
                OperationQueue.main.addOperation{
                    self.photos = photos
                    }
            case let .failure(error):
                OperationQueue.main.addOperation{
                    self.error = error
                }
            }
            
        }
        task.resume()
        
    }
    private func processPhotosRequest(data: Data?, error: Error?) -> Result<[Photo], Error>{
        
        guard let jsonData = data else {
            
            return .failure(error!)
            
        }
        let result = FlickrAPI.photos(fromJSON: jsonData)
        return result
        
    }
    
}
