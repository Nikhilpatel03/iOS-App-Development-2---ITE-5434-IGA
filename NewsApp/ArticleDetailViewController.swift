//
//  ArticleDetailViewController.swift
//  NewsApp
//
//  Created by Nikhil Patel on 2023-03-31.
//

import UIKit
import SafariServices
import CoreData

class ArticleDetailViewController: UIViewController {
    
    var article: NewsResponse.Article?
    var articleObject: ArticleObject?
    
    @IBOutlet weak var titleLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var readLaterButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        if let articleObject = articleObject{
            readLaterButton.isEnabled = false
        }
        else if let article = article{
            readLaterButton.isEnabled = true
            setupReadLaterButton()
        }
    }
    
    func configureUI() {
        
        if let articleObject = articleObject {
            titleLabel.text = articleObject.title
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.textColor = UIColor.black
            
            if let content = articleObject.content {
                let pattern = "\\[[^\\]]+\\]"
                if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
                    let range = NSMakeRange(0, content.utf16.count)
                    let modifiedContent = regex.stringByReplacingMatches(in: content, options: [], range: range, withTemplate: "<a href=\"\(articleObject.url)\">read more</a>")
                    if let htmlData = modifiedContent.data(using: .windowsCP1252, allowLossyConversion: true),
                       let attributedString = try? NSAttributedString(data: htmlData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                        contentTextView.attributedText = attributedString
                    } else {
                        contentTextView.text = content
                    }
                    
                } else {
                    contentTextView.text = content
                }
                contentTextView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
                contentTextView.textColor = UIColor.black
                contentTextView.font = UIFont.systemFont(ofSize: 15)
                contentTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                
            } else {
                contentTextView.text = ""
            }
            contentTextView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
            contentTextView.textColor = UIColor.black
            contentTextView.font = UIFont.systemFont(ofSize: 15)
            contentTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            
            if let imageUrlString = articleObject.urlToImage,
               let imageUrl = URL(string: imageUrlString) {
                URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }.resume()
                imageView.layer.borderColor = UIColor.lightGray.cgColor
            }
            
            
        } else if let article = article {
            titleLabel.text = article.title
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.textColor = UIColor.black
            
            if let content = article.content {
            
                let pattern = "\\[[^\\]]+\\]"
                if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
                    let range = NSMakeRange(0, content.utf16.count)
                    let modifiedContent = regex.stringByReplacingMatches(in: content, options: [], range: range, withTemplate: "<a href=\"\(article.url)\">read more</a>")
                    if let htmlData = modifiedContent.data(using: .windowsCP1252, allowLossyConversion: true),
                       let attributedString = try? NSAttributedString(data: htmlData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                        contentTextView.attributedText = attributedString
                    } else {
                        contentTextView.text = content
                    }
                    
                } else {
                    contentTextView.text = content
                }
                contentTextView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
                contentTextView.textColor = UIColor.black
                contentTextView.font = UIFont.systemFont(ofSize: 15)
                contentTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                
            } else {
                contentTextView.text = ""
            }
            
            if let imageUrl = article.urlToImage {
                URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }.resume()
                imageView.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
    }
        func setupReadLaterButton() {
            let readLaterButton = UIBarButtonItem(title: "Read Later", style: .plain, target: self, action: #selector(readLaterButtonTapped))
            navigationItem.rightBarButtonItem = readLaterButton
        }
    @objc func readLaterButtonTapped() {
            guard let article = article else { return }
    
            // Get a reference to the Core Data service
            let coreDataService = CoreDataService.shared
    
            // Create a new ArticleObject with the article details
            let newArticle = ArticleObject(title: article.title,
                                           author: article.author ?? "Unknown",
                                           description: article.description!,
                                           url: article.url.absoluteString,
                                           urlToImage: article.urlToImage?.absoluteString,
                                           publishedAt: Date(), content: article.content)
    
            // Add the article using the Core Data service
            coreDataService.insertNewArticleToDB(article: newArticle)
    
            // Show success message
            showSaveSuccessAlert()
        }
    
        func showSaveSuccessAlert() {
            let alert = UIAlertController(title: "Article saved", message: "The article has been saved to your Read Later list.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    
    }

    
