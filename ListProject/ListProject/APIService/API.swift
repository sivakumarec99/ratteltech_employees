//
//  API.swift
//  ListProject
//
//  Created by Murugan M on 29/12/21.
//

import Foundation

class API {
    static let shared = API()
    
    func startService<T:Codable>(urlSting: String,typeR:T.Type , handler: @escaping ((T? ,String?)->Void)) {
        
        let url = URL(string: urlSting)

        var urlRequest = URLRequest(url: url!)
         
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = "GET"
        
        let task  = URLSession.shared.dataTask(with: urlRequest) { sData, sResponce, error in
            
            if let error =  error {
                print(error)
                handler(nil ,error.localizedDescription)
            }else{
                do {
                    
                    if let httpResponse = sResponce as? HTTPURLResponse, httpResponse.statusCode != 200 {
                        print ("httpResponse.statusCode: \(httpResponse.statusCode)")
                        handler(nil ,"\(httpResponse.statusCode)")
                    }else{
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(typeR, from: sData!)
                        handler(responseModel , nil)
                    }
                    
                }catch {
                    print(error)
                }
            }
            
        }
        task.resume()
        
    }
    
}
