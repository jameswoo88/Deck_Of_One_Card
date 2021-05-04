//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by James Chun on 5/4/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

enum CardError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Internal error, Please update Deck of One Card or contact support"
        case .thrownError(let error):
            print(error.localizedDescription)
            return "The card does not exist.\nPlease select another card."
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "The server responded with bad data"
        }
    }
}
