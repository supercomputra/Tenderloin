//
//  NetworkController.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 08/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import Foundation

public enum NetworkError: String, Error {
    case missingParameters = "Parameters is missing"
    case encodingError = "Parameters encoding failed"
    case missingURL = "URL is missing"
}


struct NetworkController {
    static let environment: NetworkEnvironment = .production
    static let version = "v2.5"
    private let router: NetworkRouter = NetworkRouter<TokopediaAPI>()
    
    enum NetworkResponse: String {
        case successful = "Successful"
        case informational = "Informational"
        case multipleChoice = "Multiple choice"
        case clientError = "Client error"
        case serverError = "Server error"
        case outdated = "Outdated"
        case networkRequestError = "Network request error"
        case noData = "Response returned with no data"
        case decodingError = "Could not decode the response"
    }
    
    enum Result<String> {
        case success
        case error(String)
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 100...199:
            return .error(NetworkResponse.informational.rawValue)
        case 200...299:
            return .success
        case 300...399:
            return .error(NetworkResponse.multipleChoice.rawValue)
        case 400...499:
            return .error(NetworkResponse.clientError.rawValue)
        case 500...599:
            return .error(NetworkResponse.serverError.rawValue)
        case 600:
            return .error(NetworkResponse.outdated.rawValue)
        default:
            return .error(NetworkResponse.networkRequestError.rawValue)
        }
    }
    
    typealias SearchProductCompletionHandler = (_ product: [Product]?, _ error: String?) -> ()
    
    func searchProducts(key: String, minPrice: String, maxPrice: String, isWholesale: Bool, isOfficial: Bool, golds: Int, startingIndex: Int, items: Int, completionHandler: @escaping SearchProductCompletionHandler) {
        
        router.request(.searchProduct(key: key, minPrice: minPrice, maxPrice: maxPrice, isWholesale: isWholesale, isOfficial: isOfficial, golds: golds, startingIndex: startingIndex, items: items)) { (data: Data?, response: URLResponse?, error: Error?) in
            print(error.debugDescription)
            if error != nil {
                completionHandler(nil, "Please check the network connection")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            let result = self.handleNetworkResponse(response)
            switch result {
            case .success:
                guard let data = data else {
                    completionHandler(nil, NetworkResponse.noData.rawValue)
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(SearchProductResponse.self, from: data)
                    completionHandler(decodedData.products, nil)
                } catch {
                    completionHandler(nil, NetworkResponse.decodingError.rawValue)
                }
            case .error(let error):
                completionHandler(nil, error)
                return
            }
        }
    }
}
