//
//  CameraSelection.swift
//  Networking&Firebase
//
//  Created by Nikhil Patel on 2023-03-19.
//

import UIKit

class ImageSelection: UITableViewController, NetworkingDelegate {
    var cameras = [latestphotos]()
    var selectedImgSrc: String?
    var selectedId: Int?
    var selectedCam: String?
    var selectedEarthDate: String?
    
    
      var url1 = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/latest_photos?api_key=DEMO_KEY"
      
      override func viewDidLoad() {
          super.viewDidLoad()
          (UIApplication.shared.delegate as! AppDelegate).num = 90
          NetworkingService.shared.delegate = self
          
          NetworkingService.shared.getData2(fullurl: url1) { result in
              switch result{
              case .failure(let error):
                  print(error)
                  
              case .success(let data):
                  let nasaObject = JsonService.shared.parseNASAJson(data: data)
                  DispatchQueue.main.async {
                      self.cameras = nasaObject
                      self.tableView.reloadData()
                  }
              }
          }
      }
      
      // MARK: - Table view data source
      
      override func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
      
      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return cameras.count
      }
      
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
          
          let photo = cameras[indexPath.row]
          cell.textLabel?.text = String( photo.id)
        
          
          return cell
      }
      
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = cameras[indexPath.row]
                selectedImgSrc = photo.img_src
                selectedId = photo.id
        selectedCam = photo.camera.name
        selectedEarthDate = photo.earth_date
                
                performSegue(withIdentifier: "showImage", sender: self)
    }
      func networkingDidFinishWithError() {
          cameras = [latestphotos]()
          DispatchQueue.main.async {
              self.tableView.reloadData()
          }
      }
      
      func networkingDidFinishWithResult(allphotos: [NASAObject]) {
          DispatchQueue.main.async {
              self.cameras = allphotos.first?.latest_photos ?? []
              self.tableView.reloadData()
          }
      }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showImage" {
                let destination = segue.destination as! ImageDisplay
                destination.imgSrc = selectedImgSrc
                destination.id = selectedId
                destination.camera_name = selectedCam
                destination.earth_date = selectedEarthDate
            }
        }
            
        }
