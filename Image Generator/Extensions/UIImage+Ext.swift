//
//  UIImage + Ext.swift
//  Image Generator
//
//  Created by Evgeniy Goncharov on 19.05.2023.
//

import UIKit

extension UIImage {
    
    class func getImage(_ urlString: String?, completion: @escaping (UIImage?, Error?) -> Void) {
        guard let api = urlString,
              let apiUrl = URL(string: api) else {
            DispatchQueue.main.async {
                completion(nil, nil)
            }
            return
        }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: apiUrl){ data, _, error  in
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(UIImage(data: data), nil)
            }
            
        }.resume()
    }
}
