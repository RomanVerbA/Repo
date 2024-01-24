//
//  Json.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import Foundation

class JsonRepo {
  
  func load(completion: @escaping (Welcome) -> Void) {
    let urlString =  "https://www.dropbox.com/scl/fi/bx467tupe3nbrsf4kg42s/Programs.json?rlkey=xybrscxbwcgwyf0udyvm01k4r&dl=1"
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      
      let welcome = try! JSONDecoder().decode(Welcome.self, from: data!)
      
      DispatchQueue.main.async {
        completion(welcome)
      }
      
    }.resume()
  }
}
