//
//  TokopediaQuery.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 08/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case production
}

public enum TokopediaAPI {
    case searchProduct(key: String, minPrice: String, maxPrice: String, isWholesale: Bool, isOfficial: Bool, golds: Int, startingIndex: Int, items: Int)
}

extension TokopediaAPI: RouteType {
    
    private var envBaseURL: String {
        switch  NetworkController.environment {
        case .production:
            return "https://ace.tokopedia.com/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: envBaseURL) else {
            fatalError("""
                baseURL couldn't set.
                Please check the networkEnvironment in NetworkController
                """
            )
        }
        return url
    }
    
    var path: String {
        switch self {
        case .searchProduct(key: _, minPrice: _, maxPrice: _, isWholesale: _, isOfficial: _, golds: _, startingIndex: _, items: _):
            return "search/\(NetworkController.version)/product"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .searchProduct(key: let key, minPrice: let minPrice, maxPrice: let maxPrice, isWholesale: let isWholesale, isOfficial: let isOfficial, golds: let golds, startingIndex: let startingIndex, items: let items):
            let parameters: Parameters = [
                "q": key,
                "pmin": minPrice,
                "pmax": maxPrice,
                "wholesale": isWholesale,
                "official": isOfficial,
                "fshop": golds,
                "start": startingIndex,
                "rows": items
            ]
            return .requestWithParameters(bodyParameters: nil, urlParameters: parameters)
        }
    }
    
    var httpHeader: HTTPHeader? {
        return nil
    }
}
