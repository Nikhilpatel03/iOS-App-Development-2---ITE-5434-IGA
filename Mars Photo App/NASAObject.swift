//
//  NASAObject.swift
//  Mars Photo App
//
//  Created by Nikhil Patel on 2023-02-04.
//

import Foundation

class NASAObject : Codable {
    var photos : [photos]
}

class photos : Codable {
    var id : Int
    var img_src  : String
    var earth_date : String
    var rover : rover
}

class rover : Codable {
    var name : String
}
