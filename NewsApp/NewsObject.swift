//
//  NewsObject.swift
//  NewsApp
//
//  Created by Nikhil Patel on 2023-03-31.
//

import Foundation

class NewsResponse: Codable {
    let articles: [Article]
    
    class Article: Codable {
        let source: Source
        let author: String?
        let title: String
        let description: String?
        let url: URL
        let urlToImage: URL?
        let publishedAt: Date
        let content: String?
        
        init(source: Source, author: String?, title: String, description: String?, url: URL, urlToImage: URL?, publishedAt: Date, content: String?) {
            self.source = source
            self.author = author
            self.title = title
            self.description = description
            self.url = url
            self.urlToImage = urlToImage
            self.publishedAt = publishedAt
            self.content = content
        }
        
        class Source: Codable {
            let id: String?
            let name: String
            
            init(id: String?, name: String) {
                self.id = id
                self.name = name
            }
        }
    }
}
