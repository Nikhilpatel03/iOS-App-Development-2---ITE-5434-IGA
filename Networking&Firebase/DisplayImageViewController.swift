//
//  DisplayImageViewController.swift
//  Networking&Firebase
//
//  Created by Nikhil Patel on 2023-03-20.
//

import UIKit

class DisplayImageViewController: UIViewController ,UIScrollViewDelegate,UIGestureRecognizerDelegate{

    // MARK: - Properties
    
    var selectedImage: NASAObjectFB?
    
    // MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var earthDateLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    // MARK: - View Lifecycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        
        print(selectedImage)
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           // Check if we have a selected image
           guard let selectedImage = selectedImage else {
               // If there's no selected image, show an error message
               return
           }
        
        cameraLabel.text = "Camera: \(selectedImage.camera_name)"
        earthDateLabel.text = "Earth Date: \(selectedImage.earth_date)"
        idLabel.text = "ID: \(selectedImage.id)"
        
        // Load the image from the URL
        if let url = URL(string: selectedImage.image_src) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
    }
    var currentZoom: CGFloat = 1.0 // current zoom level of the image
       
       @IBAction func zoomInButtonPressed(_ sender: Any) {
           currentZoom += 0.1
           imageView.transform = CGAffineTransform(scaleX: currentZoom, y: currentZoom)
       }
       
       @IBAction func zoomOutButtonPressed(_ sender: Any) {
           currentZoom -= 0.1
           if currentZoom < 0.1 { // minimum zoom level
               currentZoom = 0.1
           }
           imageView.transform = CGAffineTransform(scaleX: currentZoom, y: currentZoom)
       }
    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Why are you shaking me?")
        }
     
        
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
        
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}

