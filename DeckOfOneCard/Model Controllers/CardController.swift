//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by James Chun on 5/4/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class CardController {
    
    static func fetchCard(completion: @escaping (Result<Card, CardError>) -> Void) {
        //Step 1: Create URL
        guard let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1") else { return completion(.failure(.invalidURL)) }
        
        //Step 2: Data task (Contact Server)
        URLSession.shared.dataTask(with: baseURL) { data, response, error in
            //Step 3: Handling error
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("CARD STATUS CODE: \(response.statusCode)")
            }
            
            //Step 4: Check for json data
            guard let data = data else { return completion(.failure(.noData)) }
            
            //Step 5: Decode data
            do {
                let decoder = JSONDecoder()
                let topLevelObject = try decoder.decode(TopLevelObject.self, from: data)
                guard let card = topLevelObject.cards.first else { return completion(.failure(.noData)) }
                completion(.success(card))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        //Step 1: create URL
        guard let baseURL = card.image else { return completion(.failure(.invalidURL)) }
        
        //Step 2: Data task (contact server)
        URLSession.shared.dataTask(with: baseURL) { data, response, error in
            //Step 3: Hadling Error
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("IMAGE STATUS CODE: \(response.statusCode)")
            }
            
            //Step 4: Check for json data
            guard let data = data else { return completion(.failure(.noData)) }
            
            //Step 5: Decode data - Initialize an image from the data with image(data: ) in this case.
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            completion(.success(image))
        }.resume()
    }
    
}//End of class
