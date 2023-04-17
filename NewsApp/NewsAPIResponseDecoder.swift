//
//  NewsAPIResponseDecoder.swift
//  NewsApp
//
//  Created by Nikhil Patel on 2023-03-31.
//

import Foundation

class NewsAPIResponseDecoder {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()
    
    static func decodeNewsResponse<T: NewsResponse>(from data: Data, responseClass: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        let response = try decoder.decode(responseClass, from: data)
        return response
    }
}



