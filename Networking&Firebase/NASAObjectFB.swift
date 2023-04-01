//
//  NASAObjectFB.swift
//  Networking&Firebase
//
//  Created by Nikhil Patel on 2023-03-20.
//

import Foundation
class NASAObjectFB {
    
    var camera_name: String
    var earth_date : String
    var docID: String
    var id : Int
    var image_src : String
    
    init(cameraname: String, earthdate: String, documentID: String,ID : Int, imgsrc: String){
        camera_name = cameraname
        earth_date = earthdate
        docID = documentID
        id = ID
        image_src = imgsrc
    }
    
}
