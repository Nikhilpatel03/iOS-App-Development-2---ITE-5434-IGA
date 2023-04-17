//
//  ReadLaterViewController.swift
//  NewsApp
//
//  Created by Nikhil Patel on 2023-04-10.
//

import UIKit
import CoreData

class ReadLaterViewController: UITableViewController {

    let newsAPIManager = NewsAPIManager()

    var savedArticles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Read Later"
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "articleCell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchSavedArticles()
    }

    private func fetchSavedArticles() {
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "dateSaved", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            savedArticles = try CoreDataService.shared.getAllArticles()!
            tableView.reloadData()
        } catch let error {
            print("Failed to fetch saved articles:", error)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedArticles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        let article = savedArticles[indexPath.row]
        cell.textLabel?.text = article.title
        cell.imageView?.image = UIImage(systemName: "newspaper")!.withTintColor(.red, renderingMode: .alwaysOriginal)
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        cell.detailTextLabel?.textColor = .gray
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none // Optional, to remove the selection highlight when tapped
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = savedArticles[indexPath.row]
        
        let articleObject = ArticleObject(title: selectedArticle.title ?? "",
                                          author: selectedArticle.author ?? "",
                                          description: selectedArticle.articleDescription ?? "",
                                          url: selectedArticle.url ?? "",
                                          urlToImage: selectedArticle.urlToImage ?? "",
                                          publishedAt: selectedArticle.publishedAt!,
                                          content: selectedArticle.content ?? "")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let articleDetailVC = storyboard.instantiateViewController(withIdentifier: "ArticleDetailViewController") as! ArticleDetailViewController
        articleDetailVC.articleObject = articleObject
        navigationController?.pushViewController(articleDetailVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let articleToDelete = savedArticles[indexPath.row]

            // Delete the article from the Core Data store
            CoreDataService.shared.deleteArticle(articleToDelete: articleToDelete)

            // Update the table view
            tableView.performBatchUpdates({
                savedArticles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }, completion: nil)
        }
    }

}
