//
//  ServerManager.swift
//  Gallery
//
//  Created by Apple on 27/10/21.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
}

class ServerManager: NSObject {
    
    private override init() { }
    
    static let shared = ServerManager()
    
    func getImages(onSuccess: @escaping ([PhotoModel]) -> Void, onFailure: @escaping () -> Void) {
        let urlString: String = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=42"
        if let Url = URL(string: urlString) {
            var urlRequest = URLRequest(url: Url)
            urlRequest.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                if let responseObject = response as? HTTPURLResponse {
                    print("statusCode : " + responseObject.statusCode.description)
                    
                    if responseObject.statusCode == 200 {
                        
                        if let data = data {
                            do {
                                let convertedData = try JSONDecoder().decode([PhotoModel].self, from: data)
                                onSuccess(convertedData)
                                
                            }
                            catch {
                                print("Something went wrong")
                            }
                        }
                    }
                }
            }
            dataTask.resume()
        }
        
        
    }
    
    
    
    
}

