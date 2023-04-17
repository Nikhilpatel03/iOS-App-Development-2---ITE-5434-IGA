//
//  NewsAPIManager.swift
//  NewsApp
//
//  Created by Nikhil Patel on 2023-03-31.
//

import Foundation

class NewsAPIManager {

    enum APIError: Error {
        case decodingError
        case serverError
        case invalidAPIKey
        case unknownError
    }

    let apiKey = "57ae311c2e704cc69c00bce18236d01a"
    let baseURL = "https://newsapi.org/v2"

    func fetchTopHeadlines(completion: @escaping (Result<NewsResponse, Error>) -> Void) {
            let urlString = "\(baseURL)/top-headlines?country=us&apiKey=\(apiKey)"
            guard let url = URL(string: urlString) else {
                completion(.failure(APIError.serverError))
                print("26")
                return
            }

            let request = DefaultNewsAPIRequest(url: url, responseClass: NewsResponse.self) // pass the response class here
            URLSession.shared.dataTask(with: request.urlRequest) { (data, response, error) in
                guard let data = data else {
                    completion(.failure(APIError.unknownError))
                    return
                }

                do {
                    let newsResponse = try NewsAPIResponseDecoder.decodeNewsResponse(from: data, responseClass: NewsResponse.self)
                    completion(.success(newsResponse))
                } catch {
                    completion(.failure(APIError.decodingError))
                }
            }.resume()
        }

        func fetchSearch(for query: String, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
            let urlString = "\(baseURL)/everything?q=\(query)&apiKey=\(apiKey)"
            guard let url = URL(string: urlString) else {
                completion(.failure(APIError.serverError))
                print("26")
                return
            }

            let request = DefaultNewsAPIRequest(url: url, responseClass: NewsResponse.self) // pass the response class here
            URLSession.shared.dataTask(with: request.urlRequest) { (data, response, error) in
                guard let data = data else {
                    completion(.failure(APIError.unknownError))
                    return
                }

                do {
                    let newsResponse = try NewsAPIResponseDecoder.decodeNewsResponse(from: data, responseClass: NewsResponse.self)
                    completion(.success(newsResponse))
                } catch {
                    completion(.failure(APIError.decodingError))
                }
            }.resume()
        }

}
