//
//  NewsAPIRequest.swift
//  NewsApp
//
//  Created by Nikhil Patel on 2023-04-07.
//

import Foundation

protocol NewsAPIRequest {
    var urlRequest: URLRequest { get }
    init(url: URL, responseClass: Decodable.Type)
}

extension NewsAPIRequest {
    var baseURL: String {
        return "https://newsapi.org/v2"
    }

func makeRequest(withPathComponent pathComponent: String) -> URLRequest {
        let urlString = baseURL + pathComponent
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
}

struct DefaultNewsAPIRequest<T: Decodable>: NewsAPIRequest {
    let urlRequest: URLRequest
    init(url: URL, responseClass: Decodable.Type) {
        let request = URLRequest(url: url)
               self.urlRequest = request
    }
    
    init(url: URL, responseClass: T.Type) {
        self.urlRequest = URLRequest(url: url)
    }
}


