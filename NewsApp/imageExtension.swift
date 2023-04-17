//
//  imageExtension.swift
//  NewsApp
//
//  Created by Nikhil Patel on 2023-04-16.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(from url: URL) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
    
}
