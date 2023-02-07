//
//  ViewController.swift
//  Mars Photo App
//
//  Created by Nikhil Patel on 2023-01-28.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate{
    
    @IBOutlet weak var NumberLabel: UILabel!
    @IBOutlet weak var imagePicker: UIPickerView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet var roverPicker: UIPickerView!
    
    let roverData = ["Opportunity","Curiosity","Spirit"]
    var id: [String] = []
    var img_src: [String] = []
    var url1 = "https://api.nasa.gov/mars-photos/api/v1/rovers/"
    var url2 = "/photos?earth_date="
    var url3 = "&api_key=DEMO_KEY"
    
    var rover = ""
    var date = ""
    var id_index = Int()
    var fullURL = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        roverPicker.dataSource = self
        roverPicker.delegate = self
        
        imagePicker.dataSource = self
        imagePicker.delegate = self
        
        
    }
    @objc func dateChange(datePicker: UIDatePicker)
    {
        date = formatDate(date: datePicker.date)
        fullURL = url1 + rover + url2 + date + url3
        fetchData(url: fullURL)
    }
    func formatDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-M-d"
        return formatter.string(from: date)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var count = 0
        if(pickerView.tag == 1)
        {
            count = roverData.count
        }
        else if(pickerView.tag == 2)
        {
            count = id.count
        }
        
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        var data = ""
        if(pickerView.tag == 1)
        {
            data = roverData[row]
        }
        else if (pickerView.tag == 2)
        {
            data = id[row]
        }
        return data
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 1){
            rover = roverData[row]
        }
        else if (pickerView.tag == 2){
            id = []
            id_index = row
            fetchData(url: fullURL)
        }
        
    }
    func fetchID(url: String){
        
    }
    func fetchData(url: String){
        print(url)
        NetworkingService.shared.getData2(fullurl: url) {result in
                                switch result {
                                case .failure(let error):
                                    print(error)
                                    break
                                case .success(let data):
                                    print(data)
                                   let wo = JsonService.shared.parseNASAJson(data: data)
                                    
                                    for i in wo.photos{
                                        self.id.append(String(i.id))
                                    }
                                    for i in wo.photos{
                                        self.img_src.append(i.img_src)
                                    }
                                    NetworkingService.shared.getData2(fullurl: wo.photos[self.id_index].img_src) { result in
                                        switch result {
                                        case .success(let imageData):
                                            DispatchQueue.main.async {
                                                self.photo.image = UIImage(data: imageData)
                                                
                                                self.NumberLabel.text = "Number Of Photos: " + String(self.id.count)
                                                
                                                self.imagePicker.reloadAllComponents()
                                                
                                            }
                                            break
                                        case .failure(let error):
                                            break
                                        }
                                    }
            
//                                    DispatchQueue.main.async {
//                                        self.main.text = wo.weather[0].main
//
//                                    }
            
                                    break
                                }
            
            
                            }
        }
        
    }




