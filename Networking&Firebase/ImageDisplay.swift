//
//  ImageDisplay.swift
//  Networking&Firebase
//
//  Created by Nikhil Patel on 2023-03-19.
//

import UIKit

class ImageDisplay: UIViewController{
    var imgSrc: String?
    var camera_name: String?
    var earth_date: String?
    var id : Int?

    
    @IBOutlet weak var done: UIImageView!
    
    @IBAction func btnPressed(_ sender: Any) {
        FireBaseService.shared.insertIntoFirestore(id: id!, camera: camera_name!, earthDate: earth_date!, image: imgSrc!) { success in
            if success {
                let alert = UIAlertController(title: "Added to Favourites", message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Already added to favourites", message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    }
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = self.navigationController {
            print("Navigation stack:")
            for viewController in navigationController.viewControllers {
                print("- \(viewController)")
            }
            
            
        }
      
        // Set the image of the UIImageView
           if let imgSrc = imgSrc, let url = URL(string: imgSrc), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
               imageView.image = image
           } else {
              
           }
    }
   

}
