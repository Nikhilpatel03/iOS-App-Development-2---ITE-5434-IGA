//
//  ArticleObject.swift
//  NewsApp
//
//  Created by Nikhil Patel on 2023-04-10.
//

import Foundation

struct ArticleObject: Codable {
    let title: String
    let author: String
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
}

