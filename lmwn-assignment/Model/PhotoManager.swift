//
//  PhotoManager.swift
//  lmwn-assignment
//
//  Created by ggolfz on 14/10/2564 BE.
//

import Foundation

extension Int {
    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return numberFormatter
    }()

    var delimiter: String {
        return Int.numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

protocol PhotoManagerDelegate {
    func updatePhotoData(_ photoManager:PhotoManager,photoList:PhotoList)
}

struct PhotoList {
    var lists: [PhotoData]
}
struct PhotoData {
    var imageURL: String
    var imageName: String
    var imageDescription: String
    var like: Int
    var likeString:String {
        like.delimiter
    }
}


struct PhotoManager {
    let baseURL = "https://api.500px.com/v1/photos?feature=popular&page=1"
    var delegate: PhotoManagerDelegate?
    func fetchPhotoData () {
        if let url = URL(string:baseURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data,response,error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let photoList = self.parseJSON(safeData) {
                        self.delegate?.updatePhotoData(self, photoList: photoList)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ data:Data) -> PhotoList? {
           let decoder = JSONDecoder()
        var photoList:[PhotoData] = []
           do {
               let decoderData = try decoder.decode(PhotoJSON.self, from: data)
               for photo in decoderData.photos {
                   let imageURL = photo.imageURL[0]
                   let imageName = photo.name
                   let imageDescription = photo.photoDescription
                   let like = photo.votesCount
                   photoList.append(PhotoData(imageURL: imageURL, imageName: imageName, imageDescription: imageDescription, like: like))
               }
           } catch {
               print(error)
           }
        return PhotoList(lists: photoList)
       }
}

