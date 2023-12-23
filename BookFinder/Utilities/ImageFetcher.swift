//
//  ImageFetcher.swift
//  BookFinder
//
//  Created by Geisel Roque on 22/12/23.
//

import Alamofire
import UIKit

class ImageFetcher {
    static func downloadImageFromURL(urlString: String, completion: @escaping (UIImage?) -> Void) {
        AF.request(urlString).responseData { response in
            switch response.result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        completion(image)
                    } else {
                        completion(nil)
                    }
                case .failure(let error):
                    print("Error downloading image: \(error.localizedDescription)")
                    completion(nil)
            }
        }
    }
}
