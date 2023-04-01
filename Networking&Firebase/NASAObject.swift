//
//  NASAObject.swift
//  Networking&Firebase
//
//  Created by Nikhil Patel on 2023-03-19.
//

import Foundation
class NASAObject : Codable {
    var latest_photos : [latestphotos]
}

class latestphotos : Codable {
    var id : Int
    var camera : camera
    var img_src  : String
    var earth_date : String
    
}

class camera : Codable {
    var name : String
}

