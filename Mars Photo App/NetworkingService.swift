//
//  NetworkingService.swift
//  Mars Photo App
//
//  Created by Nikhil Patel on 2023-02-04.
//

import Foundation
protocol NetworkingDelegate {
    func networkingDidFinishWithError()
    func networkingDidFinishWithResult(allCities: [String])
}


class NetworkingService {
    
    var delegate: NetworkingDelegate?
    static var shared = NetworkingService()
    
    func getData2(fullurl: String, completionHandler: @escaping (Result<Data,Error>)->Void){
        
        let urlObject = URL(string: fullurl)
        
        // check if the urlObject is correct
        
        if let correctURL = urlObject {
            
            
            URLSession.shared.dataTask(with: correctURL) { data, response, error in
                
                if let error = error {
                    completionHandler(.failure(error))
                }
                else {
                    completionHandler(.success(data!))
                }
            }.resume()
        }
    }
}
