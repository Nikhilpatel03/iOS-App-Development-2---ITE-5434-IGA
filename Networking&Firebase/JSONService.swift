//
//  JSONService.swift
//  Networking&Firebase
//
//  Created by Nikhil Patel on 2023-03-19.
//


import Foundation

class JsonService {
    static var shared = JsonService()
    
    func parseNASAJson (data : Data) -> [latestphotos] {
        let xData = (String(data: data, encoding: .utf8)?.data(using: .utf8))!
        let NASAObj: NASAObject
        do {
            NASAObj = try JSONDecoder().decode(NASAObject.self, from: xData)
            print(NASAObj)
            return NASAObj.latest_photos
        } catch {
            print(error)
            return []
        }
    }
}
