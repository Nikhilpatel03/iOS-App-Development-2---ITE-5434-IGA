//
//  NewsSearchTableViewController.swift
//  NewsApp
//
//  Created by Nikhil Patel on 2023-04-06.
//

import UIKit

class NewsSearchTableViewController: UITableViewController {

    let newsAPIManager = NewsAPIManager()

    var searchController: UISearchController!
    var searchResults: [NewsResponse.Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        setupSearchController()
    }

    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    func fetchSearchResults(for query: String) {
        newsAPIManager.fetchSearch(for: query) { (result) in
            switch result {
            case .success(let response):
                self.searchResults = response.articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        let article = searchResults[indexPath.row]
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
            destination.article =  searchResults[tableView.indexPathForSelectedRow!.row]
        }
    }
}

extension NewsSearchTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        fetchSearchResults(for: query)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResults.removeAll()
        tableView.reloadData()
    }
}

