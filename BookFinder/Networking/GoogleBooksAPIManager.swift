//
//  GoogleBooksAPIManager.swift
//  BookFinder
//
//  Created by Geisel Roque on 21/12/23.
//

import Alamofire

class GoogleBooksAPI {
  func searchBooks(query: String, completion: @escaping (Result<[BookDetailsData], Error>) -> Void) {
    let parameters: [String: Any] = [
      "q": query,
      "key": Constant.apiKey
    ]

    AF.request(Constant.baseURL, parameters: parameters)
      .validate()
      .responseDecodable(of: GoogleBooksResponse.self) { response in
        switch response.result {
        case .success(let response):
          completion(.success(response.items))
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
}

struct GoogleBooksResponse: Codable {
  let items: [BookDetailsData]
}
