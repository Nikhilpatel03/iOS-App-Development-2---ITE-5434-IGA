//
//  JSONService.swift
//  Mars Photo App
//
//  Created by Nikhil Patel on 2023-02-04.
//

import Foundation

class JsonService {
    static var shared = JsonService()
    
//    func parseJson (data : Data) -> [City]{
//
//        var cities = [City]()
//        let xData = String(data: data, encoding: .utf8)?.data(using: .utf8)
//        let listOfCities = try? JSONDecoder().decode([String].self,from: xData!)
//                            // "Toronto , ON, Canada"
//
//        _ =   listOfCities?.reduce(into: [String]()){
//                            let separatesNames = $1.split(separator: ",") // ["Toronto", "ON" , "Canada"]
//
//
//            let c = String(separatesNames[0]).trimmingCharacters(in: .whitespaces)
//            let st = String(separatesNames[1]).trimmingCharacters(in: .whitespaces)
//            let con = String(separatesNames[2]).trimmingCharacters(in: .whitespaces)
//            let city = City(city: c , state: st, country: con )
//            cities.append(city)
//        }
//        return cities
//    }
    
    
    func parseNASAJson (data : Data) -> NASAObject {
        let xData = (String(data: data, encoding: .utf8)?.data(using: .utf8))!
        let NASAObj : NASAObject?
        do{
            NASAObj = try? JSONDecoder().decode(NASAObject.self, from: xData)
            print(NASAObj)
        }catch {
            print(error)
        }
      
        return NASAObj!
        
    }
}
