//
//  CoreDataService.swift
//  NewsApp
//
//  Created by Nikhil Patel on 2023-04-10.
//

import Foundation
import CoreData

class CoreDataService {
    static let shared = CoreDataService()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func insertNewArticleToDB(article: ArticleObject) {
        // Check if the article is not in the database
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url = %@", article.url)
        
        do {
            let listOfSimilarArticles = try persistentContainer.viewContext.fetch(fetchRequest)
            
            if listOfSimilarArticles.count > 0 {
                // Article already exists in the database, do nothing
            } else {
                // Create a new Article entity and save it to the database
                let newArticle = Article(context: persistentContainer.viewContext)
                newArticle.title = article.title
                newArticle.author = article.author
                newArticle.articleDescription = article.description
                newArticle.url = article.url
                newArticle.urlToImage = article.urlToImage
                newArticle.publishedAt = article.publishedAt
                newArticle.content = article.content
                saveContext()
            }
        } catch {
            print("Error fetching articles: \(error.localizedDescription)")
        }
    }
    
    func getAllArticles() -> [Article]? {
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        
        do {
            let articles = try persistentContainer.viewContext.fetch(fetchRequest)
            return articles
        } catch {
            print("Error fetching articles: \(error.localizedDescription)")
            return nil
        }
    }
    
    func deleteArticle(articleToDelete: Article) {
        persistentContainer.viewContext.delete(articleToDelete)
        saveContext()
    }
}
