//
//  TableViewController.swift
//  Networking&Firebase
//
//  Created by Nikhil Patel on 2023-03-19.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }
    func updateUI(){
        
        FireBaseService.shared.getAllImages{ list in
            FireBaseService.shared.allImages = list
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FireBaseService.shared.allImages.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = String(FireBaseService.shared.allImages[indexPath.row].id)
        
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FireBaseService.shared.deleteOneImage(todelete: FireBaseService.shared.allImages[indexPath.row])
            updateUI()
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedObject = FireBaseService.shared.allImages[indexPath.row]
        performSegue(withIdentifier: "selectedImage", sender: selectedObject)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedImage" {
            let displayImageVC = segue.destination as! DisplayImageViewController
            if let selectedObject = sender as? NASAObjectFB {
                displayImageVC.selectedImage = selectedObject
            }
        }
    }
}


