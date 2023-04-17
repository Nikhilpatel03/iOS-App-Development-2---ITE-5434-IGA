//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Nikhil Patel on 2023-03-31.
//

import UIKit

class NewsTableViewController: UITableViewController {

    let newsAPIManager = NewsAPIManager()

    var articles: [NewsResponse.Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        fetchTopHeadlines()
    }

    func fetchTopHeadlines() {
        newsAPIManager.fetchTopHeadlines { (result) in
            switch result {
            case .success(let NewsResponse):
                self.articles = NewsResponse.articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching top headlines: \(error.localizedDescription)")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title
        cell.imageView?.image = UIImage(systemName: "newspaper")!.withTintColor(.red, renderingMode: .alwaysOriginal)
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        cell.detailTextLabel?.textColor = .gray
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none // Optional, to remove the selection highlight when tapped
        return cell
    }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "articleSelected" {
                let destination = segue.destination as! ArticleDetailViewController
                destination.article =  articles[tableView.indexPathForSelectedRow!.row]
            }
        }

}
